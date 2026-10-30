#!/usr/bin/env bash
# Restore a backup into a fresh database (default: hotel_restore).
# Usage: ./scripts/restore.sh [backup-file]   (defaults to the newest in backups/)
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] && { set -a; . ./.env; set +a; }
DB_USER="${POSTGRES_USER:-app}"; DB="${POSTGRES_DB:-hotel}"
DIR="${BACKUP_DIR:-backups}"; RESTORE_DB="${RESTORE_DB:-hotel_restore}"

FILE="${1:-$(ls -1t "$DIR"/*.dump 2>/dev/null | head -n1 || true)}"
[ -f "$FILE" ] || { echo "No backup found. Run ./scripts/backup.sh first." >&2; exit 1; }
[ "$RESTORE_DB" != "$DB" ] || { echo "RESTORE_DB must differ from $DB" >&2; exit 1; }

psql_() { docker compose exec -T db psql -U "$DB_USER" -v ON_ERROR_STOP=1 "$@"; }

psql_ -d postgres -c "DROP DATABASE IF EXISTS \"$RESTORE_DB\" WITH (FORCE)"
psql_ -d postgres -c "CREATE DATABASE \"$RESTORE_DB\""
docker compose exec -T db pg_restore -U "$DB_USER" -d "$RESTORE_DB" --no-owner --exit-on-error < "$FILE"

echo "Restored $FILE into '$RESTORE_DB'. Row counts (source vs restored):"
for t in hotel_bookings booking_events; do
  s=$(psql_ -d "$DB" -tAc "SELECT count(*) FROM $t")
  r=$(psql_ -d "$RESTORE_DB" -tAc "SELECT count(*) FROM $t")
  echo "  $t: $s vs $r"
done
