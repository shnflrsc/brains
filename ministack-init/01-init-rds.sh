#!/bin/bash
set -eo pipefail

echo "==> MiniStack ready. Initializing RDS PostgreSQL instance..."

aws rds create-db-instance \
    --db-instance-identifier brains-postgres \
    --db-instance-class db.t4g.micro \
    --engine postgres \
    --master-username "${POSTGRES_USER}" \
    --master-user-password "${POSTGRES_PASSWORD}" \
    --allocated-storage 20 \
    --db-name "${POSTGRES_DB}" || true

echo "==> RDS PostgreSQL instance requested."