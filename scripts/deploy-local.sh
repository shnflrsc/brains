#!/usr/bin/env bash
# scripts/deploy-local.sh
# Deploy Spring Boot to local MiniStack ECS Fargate and verify RDS connection

set -euo pipefail

ENDPOINT="${ENDPOINT:-http://localhost:4566}"
CLUSTER_NAME="${CLUSTER_NAME:-brains-cluster}"
TASK_FAMILY="${TASK_FAMILY:-brains-task}"
IMAGE_NAME="${IMAGE_NAME:-brains:latest}"
SKIP_BUILD="${SKIP_BUILD:-false}"

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-test}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-test}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
export AWS_REGION="${AWS_REGION:-us-east-1}"

echo ""
echo "[STEP] Checking MiniStack connectivity at $ENDPOINT..."
if ! curl -s -f "$ENDPOINT/_ministack/health" > /dev/null; then
    echo "[ERROR] Cannot connect to MiniStack at $ENDPOINT. Please run 'docker compose up -d' first."
    exit 1
fi
echo "[SUCCESS] MiniStack is online and healthy."

echo ""
echo "[STEP] Checking RDS PostgreSQL instance status..."
DB_STATUS=$(aws --endpoint-url="$ENDPOINT" rds describe-db-instances \
    --query "DBInstances[?DBInstanceIdentifier=='brains-postgres'].DBInstanceStatus" \
    --output text 2>/dev/null || true)

if [ -z "$DB_STATUS" ] || [ "$DB_STATUS" = "None" ]; then
    echo "[WARN] RDS instance 'brains-postgres' not found. Creating it now..."
    aws --endpoint-url="$ENDPOINT" rds create-db-instance \
        --db-instance-identifier brains-postgres \
        --db-instance-class db.t4g.micro \
        --engine postgres \
        --master-username postgres \
        --master-user-password postgres \
        --allocated-storage 20 \
        --db-name brains > /dev/null

    echo "Waiting for RDS instance to become available..."
    aws --endpoint-url="$ENDPOINT" rds wait db-instance-available --db-instance-identifier brains-postgres
    echo "[SUCCESS] RDS PostgreSQL instance created and available."
else
    echo "[SUCCESS] RDS PostgreSQL instance 'brains-postgres' is $DB_STATUS."
fi

if [ "$SKIP_BUILD" != "true" ]; then
    echo ""
    echo "[STEP] Building Docker image '$IMAGE_NAME'..."
    docker build -t "$IMAGE_NAME" .
    echo "[SUCCESS] Docker image '$IMAGE_NAME' built successfully."
fi

echo ""
echo "[STEP] Registering ECS Task Definition from ecs-task-def.json..."
REG_OUTPUT=$(aws --endpoint-url="$ENDPOINT" ecs register-task-definition --cli-input-json file://ecs-task-def.json)
REVISION=$(echo "$REG_OUTPUT" | grep -o '"revision": [0-9]*' | head -n 1 | awk '{print $2}')
echo "[SUCCESS] Registered Task Definition: $TASK_FAMILY:$REVISION"

echo ""
echo "[STEP] Ensuring ECS cluster '$CLUSTER_NAME' exists..."
aws --endpoint-url="$ENDPOINT" ecs create-cluster --cluster-name "$CLUSTER_NAME" > /dev/null
echo "[SUCCESS] Cluster '$CLUSTER_NAME' ready."

echo ""
echo "[STEP] Checking for existing tasks to replace..."
EXISTING_TASKS=$(aws --endpoint-url="$ENDPOINT" ecs list-tasks --cluster "$CLUSTER_NAME" --query "taskArns[]" --output text 2>/dev/null || true)
if [ -n "$EXISTING_TASKS" ] && [ "$EXISTING_TASKS" != "None" ]; then
    for TASK_ARN in $EXISTING_TASKS; do
        echo "Stopping existing task: $TASK_ARN"
        aws --endpoint-url="$ENDPOINT" ecs stop-task --cluster "$CLUSTER_NAME" --task "$TASK_ARN" > /dev/null || true
    done
    sleep 2
fi

echo ""
echo "[STEP] Running new task on MiniStack ECS (Fargate)..."
RUN_OUTPUT=$(aws --endpoint-url="$ENDPOINT" ecs run-task \
    --cluster "$CLUSTER_NAME" \
    --task-definition "$TASK_FAMILY:$REVISION" \
    --launch-type FARGATE)

TASK_ARN=$(echo "$RUN_OUTPUT" | grep -o '"taskArn": "[^"]*"' | head -n 1 | cut -d'"' -f4)
echo "[SUCCESS] Task launched: $TASK_ARN"

echo ""
echo "[STEP] Waiting for container initialization..."
sleep 5

cat << EOF

=======================================================
 Deployment Complete!
=======================================================
 Cluster:       $CLUSTER_NAME
 Task Family:   $TASK_FAMILY (Revision $REVISION)
 Database:      brains-postgres (MiniStack RDS on port 15432)

 Endpoints:
   - Actuator Health: http://localhost:8080/actuator/health
   - Swagger UI:      http://localhost:8080/swagger-ui/index.html
   - PvZ Entries API: http://localhost:8080/api/v1/entries

 Useful Commands:
   - View Container Logs:  docker logs -f \$(docker ps -q --filter ancestor=$IMAGE_NAME)
   - Stop Running Task:    aws --endpoint-url=$ENDPOINT ecs stop-task --cluster $CLUSTER_NAME --task $TASK_ARN
=======================================================
EOF
