# Logto (OIDC Provider)

Manage all my users, authentication and authorization with a single centralized service.

## Environment Variables

<!-- TRUST_PROXY_HEADER=1
DB_URL="postgres://"
ENDPOINT="https://oidc.jabed.dev"
ADMIN_ENDPOINT="https://logto.jabed.dev" -->

| Variable               | Description                                                                 | Default Value          |
|------------------------|-----------------------------------------------------------------------------|------------------------|
| `TRUST_PROXY_HEADER`   | Trust proxy headers (e.g., `X-Forwarded-For`)                               | `0`                    |
| `DB_URL`               | Database connection URL (PostgreSQL)                                        | `postgres://`         |
| `ENDPOINT`             | Public endpoint of your Logto instance (used in OIDC discovery)               | `https://oidc.jabed.dev` |
| `ADMIN_ENDPOINT`       | Public endpoint of your Logto admin console                                  | `https://logto.jabed.dev` |

## Labels

- `traefik.enable=true` to enable Traefik for this service.
- `traefik.http.routers.logto-oidc.entrypoints=https` to define the entry point for the OIDC service.
- `traefik.http.routers.logto-oidc.rule=Host(`oidc.jabed.dev`)` to route requests based on the host.
- `traefik.http.routers.logto-oidc.tls=true` to enable TLS for the OIDC service.
- `traefik.http.routers.logto-oidc.tls.certresolver=production` to specify the certificate resolver.
- `traefik.http.routers.logto-oidc.service=logto-oidc` to define the service name.
- `traefik.http.services.logto-oidc.loadbalancer.server.port=3001` to specify the internal port for the OIDC service.
- `traefik.http.routers.logto-admin.entrypoints=https` to define the entry point for the admin interface.
- `traefik.http.routers.logto-admin.rule=Host(`logto.jabed.dev`)` to route requests based on the host.
- `traefik.http.routers.logto-admin.tls=true` to enable TLS for the admin interface.
- `traefik.http.routers.logto-admin.tls.certresolver=production` to specify the certificate resolver.
- `traefik.http.routers.logto-admin.service=logto-admin` to define the service name.
- `traefik.http.services.logto-admin.loadbalancer.server.port=3002` to specify the internal port for the admin interface.

### Initial Setup

When running for the first time, edit the entrypoint to run the seed command, and in other case just remove the seed command to avoid re-seeding.
