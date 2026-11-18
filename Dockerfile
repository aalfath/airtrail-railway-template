# AirTrail for Railway: the official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM johly/airtrail:v3.14.0@sha256:69ef0a421d6a5f99c06d04ea6b66445a5d1261dd533d6efe3bd8bc3e2dfd018f

COPY railway-start.sh /app/bin/railway-start.sh
RUN chmod 755 /app/bin/railway-start.sh

# The upstream entrypoint runs as root only long enough to hand the uploads
# volume to PUID:PGID (1000:1000), applies database migrations, then starts
# the server. railway-start.sh only fills in Railway defaults before that.
EXPOSE 3000/tcp
ENTRYPOINT ["/app/bin/railway-start.sh"]
