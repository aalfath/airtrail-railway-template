#!/bin/sh
# Railway defaults for AirTrail, then hand over to the upstream entrypoint.
set -e

# Port the server listens on. The template's public domain targets 3000.
export PORT="${PORT:-3000}"

# The exact public URL. Sign-in fails when it doesn't match the browser's
# address bar, so fall back to the service's Railway domain.
if [ -z "$ORIGIN" ] && [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  export ORIGIN="https://$RAILWAY_PUBLIC_DOMAIN"
fi

# Uploads (airline icons) live on the Railway volume mounted here.
export UPLOAD_LOCATION="${UPLOAD_LOCATION:-/app/uploads}"
mkdir -p "$UPLOAD_LOCATION"

# Railway's edge overwrites X-Real-IP with the real client address, so the
# login and OAuth rate limits count each visitor separately instead of
# sharing one bucket for the proxy's address.
export ADDRESS_HEADER="${ADDRESS_HEADER:-X-Real-IP}"

if [ -z "$DB_URL" ]; then
  echo "DB_URL is not set. Point it at PostgreSQL, e.g. \${{Postgres.DATABASE_URL}}." >&2
  exit 1
fi

exec /app/bin/entrypoint.sh "$@"
