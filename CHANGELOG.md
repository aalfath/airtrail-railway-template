# Changelog

Breaking changes are listed first in each entry. Read the entry before you apply an update in Railway, and take a database backup first: AirTrail's migrations only run forward.

## v3.14.0 (2026-11-18)

- First release of this template: AirTrail [v3.14.0](https://github.com/johanohly/AirTrail/releases/tag/v3.14.0), image `johly/airtrail:v3.14.0@sha256:69ef0a421d6a5f99c06d04ea6b66445a5d1261dd533d6efe3bd8bc3e2dfd018f`.
- Bundled Railway Postgres, uploads on a volume, health check on `/api/ping`, `ORIGIN` from the Railway domain, client IP from `X-Real-IP`.
