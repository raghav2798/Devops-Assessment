#!/usr/bin/env bash
# Timestamped dump of the local database -> backups/<db>_<timestamp>.dump
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] && { set -a; . ./.env; set +a; }
DB_USER="${POSTGRES_USER:-app}"; DB="${POSTGRES_DB:-hotel}"; DIR="${BACKUP_DIR:-backups}"

mkdir -p "$DIR"
FILE="$DIR/${DB}_$(date -u +%Y%m%dT%H%M%SZ).dump"
docker compose exec -T db pg_dump -U "$DB_USER" -d "$DB" --format=custom --no-owner > "$FILE"
echo "Backup written: $FILE"
