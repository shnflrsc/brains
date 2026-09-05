# scripts/deploy-local.ps1
# Deploy Spring Boot to local MiniStack ECS Fargate and verify RDS connection

[CmdletBinding()]
param(
    [string]$Endpoint = "http://localhost:4566",
    [string]$ClusterName = "brains-cluster",
    [string]$TaskFamily = "brains-task",
    [string]$ImageName = "brains:latest",
    [switch]$SkipBuild
)

$ErrorActionPreference = "Stop"

# Ensure AWS credentials exist for local emulator
$env:AWS_ACCESS_KEY_ID = $env:AWS_ACCESS_KEY_ID ?? "test"
$env:AWS_SECRET_ACCESS_KEY = $env:AWS_SECRET_ACCESS_KEY ?? "test"
$env:AWS_DEFAULT_REGION = $env:AWS_DEFAULT_REGION ?? "us-east-1"
$env:AWS_REGION = $env:AWS_REGION ?? "us-east-1"

function Write-Step {
    param([string]$Message)
    Write-Host "`n[STEP] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

# 1. Verify MiniStack is running
Write-Step "Checking MiniStack connectivity at $Endpoint..."
function Test-MiniStackHealth {
    param([string]$Url)
    try {
        $resp = Invoke-WebRequest -Uri $Url -Method Get -TimeoutSec 5
        if ($resp.StatusCode -ne 200) {
            throw "MiniStack returned HTTP $($resp.StatusCode)"
        }
        return $true
    } catch {
        Write-Warn "Health probe $Url failed: $($_.Exception.Message)"
        return $false
    }
}

$probeUrls = @("$Endpoint/_ministack/health", "$("$Endpoint" -replace 'localhost', '127.0.0.1')/_ministack/health") | Select-Object -Unique
$connected = $false
foreach ($probe in $probeUrls) {
    if (Test-MiniStackHealth $probe) {
        Write-Success "MiniStack is online and healthy ($probe)."
        $connected = $true
        break
    }
}
if (-not $connected) {
    Write-Error "Cannot connect to MiniStack. Please run 'docker compose up -d' first."
    exit 1
}

# 2. Verify RDS Database instance is available
Write-Step "Checking RDS PostgreSQL instance status..."
$dbStatus = aws --endpoint-url=$Endpoint rds describe-db-instances `
    --query "DBInstances[?DBInstanceIdentifier=='brains-postgres'].DBInstanceStatus" `
    --output text

if (-not $dbStatus -or $dbStatus -eq "None") {
    Write-Warn "RDS instance 'brains-postgres' not found. Creating it now..."
    aws --endpoint-url=$Endpoint rds create-db-instance `
        --db-instance-identifier brains-postgres `
        --db-instance-class db.t4g.micro `
        --engine postgres `
        --master-username postgres `
        --master-user-password postgres `
        --allocated-storage 20 `
        --db-name brains | Out-Null

    Write-Host "Waiting for RDS instance to become available..."
    aws --endpoint-url=$Endpoint rds wait db-instance-available --db-instance-identifier brains-postgres
    Write-Success "RDS PostgreSQL instance created and available."
} else {
    Write-Success "RDS PostgreSQL instance 'brains-postgres' is $dbStatus."
}

# 3. Build Docker Image (unless -SkipBuild is passed)
if (-not $SkipBuild) {
    Write-Step "Building Docker image '$ImageName'..."
    docker build -t $ImageName .
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Docker build failed."
        exit 1
    }
    Write-Success "Docker image '$ImageName' built successfully."
} else {
    Write-Host "Skipping Docker build (-SkipBuild specified)." -ForegroundColor DarkGray
}

# 4. Register ECS Task Definition
Write-Step "Registering ECS Task Definition from ecs-task-def.json..."
$regOutput = aws --endpoint-url=$Endpoint ecs register-task-definition --cli-input-json file://ecs-task-def.json
$revision = ($regOutput | ConvertFrom-Json).taskDefinition.revision
Write-Success "Registered Task Definition: ${TaskFamily}:${revision}"

# 5. Ensure ECS Cluster exists
Write-Step "Ensuring ECS cluster '$ClusterName' exists..."
aws --endpoint-url=$Endpoint ecs create-cluster --cluster-name $ClusterName | Out-Null
Write-Success "Cluster '$ClusterName' ready."

# 6. Stop existing tasks in this cluster to prevent port collisions on 8080
Write-Step "Checking for existing tasks to replace..."
$existingTasks = aws --endpoint-url=$Endpoint ecs list-tasks --cluster $ClusterName --query "taskArns[]" --output text
if ($existingTasks -and $existingTasks -ne "None") {
    $taskArns = $existingTasks -split "\s+"
    foreach ($arn in $taskArns) {
        if ($arn) {
            Write-Host "Stopping existing task: $arn" -ForegroundColor DarkGray
            aws --endpoint-url=$Endpoint ecs stop-task --cluster $ClusterName --task $arn | Out-Null
        }
    }
    Start-Sleep -Seconds 2
}

# 7. Run Task on Fargate
Write-Step "Running new task on MiniStack ECS (Fargate)..."
$runOutput = aws --endpoint-url=$Endpoint ecs run-task `
    --cluster $ClusterName `
    --task-definition "$TaskFamily`:$revision" `
    --launch-type FARGATE

$newTaskArn = ($runOutput | ConvertFrom-Json).tasks[0].taskArn
Write-Success "Task launched: $newTaskArn"

# 8. Wait briefly and display endpoints
Write-Step "Waiting for container initialization..."
Start-Sleep -Seconds 5

Write-Host @"

=======================================================
 Deployment Complete!
=======================================================
 Cluster:       $ClusterName
 Task Family:   $TaskFamily (Revision $revision)
 Database:      brains-postgres (MiniStack RDS on port 15432)

 Endpoints:
   - Actuator Health: http://localhost:8080/actuator/health
   - Swagger UI:      http://localhost:8080/swagger-ui/index.html
   - PvZ Entries API: http://localhost:8080/api/v1/entries

 Useful Commands:
   - View Container Logs:  docker logs -f `$(docker ps -q --filter ancestor=$ImageName)
   - Stop Running Task:    aws --endpoint-url=$Endpoint ecs stop-task --cluster $ClusterName --task $newTaskArn
=======================================================
"@ -ForegroundColor Green
