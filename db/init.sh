#!/bin/sh
# Runs on first start of an empty volume: migrations, then seed.
set -e
for f in /db/migrations/*.sql /db/seed/*.sql; do
  psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$f"
done
