[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/airtrail-2?utm_medium=integration&utm_source=button&utm_campaign=airtrail)

# AirTrail on Railway

A one-click Railway template for [AirTrail](https://github.com/johanohly/AirTrail), the open-source personal flight tracker: a world map of every flight you've taken, statistics, imports from other trackers, and multiple users.

## What it deploys

| Service | Source | Data |
|---|---|---|
| **AirTrail** | this repo's `Dockerfile`: the official image `johly/airtrail:v3.14.0`, pinned by digest | volume at `/app/uploads` (airline icons you upload) |
| **Postgres** | Railway's PostgreSQL | volume at `/var/lib/postgresql/data` (flights, users, settings) |

The AirTrail service gets a public `*.up.railway.app` domain on port 3000 and a health check on `/api/ping`. Database migrations run on every start, and the container stops if one fails.

## Variables

| Variable | Default | Notes |
|---|---|---|
| `DB_URL` | `${{Postgres.DATABASE_URL}}` | Private-network connection to the bundled Postgres. Its password is generated per deploy. |
| `ORIGIN` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | The exact URL you open AirTrail at. Change it if you add a custom domain, or sign-in fails. |
| `PORT` | `3000` | Port the server listens on; the public domain targets it. |

Nothing to fill in at deploy time. The start script (`railway-start.sh`) also sets `UPLOAD_LOCATION=/app/uploads` and `ADDRESS_HEADER=X-Real-IP` (Railway's edge sets it to the real client address, so login rate limits work per visitor).

Optional settings (OAuth sign-in, AeroDataBox flight lookup, basemap providers, aircraft photos) can be added as variables later; see the [environment variable reference](https://airtrail.johan.ohly.dk/docs/administration/environment-variables). Most of them can also be set in the app under **Settings**.

## After deploy

Open the public URL. The first visit shows the **Welcome** screen, where you create the owner account. There is no default account or password. The first start downloads airport and airline data, which takes about a minute.

## Updates

Each AirTrail release is a new commit to `main` here that bumps the pinned tag and digest, with a [`CHANGELOG.md`](CHANGELOG.md) entry (breaking changes first). Railway then shows an "update available" notice in projects deployed from this template, and you choose when to apply it. Take a database backup first: AirTrail's migrations only run forward.

## Licence

AirTrail is GPL-3.0, by Johan Ohly and contributors. This wrapper only adds a start script.
