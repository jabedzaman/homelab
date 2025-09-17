# Postgres (database)

Database for multiple internal services, plus development use.

---

### Environment Variables

| Variable               | Description                                                                 | Default Value          |
|------------------------|-----------------------------------------------------------------------------|------------------------|
| `POSTGRES_USER`        | Username for the Postgres database                                          | `jabed`            |
| `POSTGRES_PASSWORD`    | Password for the Postgres database                                          | `changeme`            |
| `POSTGRES_DB`          | Name of the default database to be created                                 | `jabed`            |     
| `POSTGRES_ROOT_PASSWORD`   | Password for the Postgres superuser (postgres)                             | `changeme`            |
| `TZ`                   | Timezone for the Postgres container                                         | `Asia/Kolkata`                 |

### Labels

- `traefik.enable=true` - Enable Traefik for this service
- `traefik.docker.network=traefik-network` - Specify the Docker network Traefik should use
- `traefik.tcp.routers.postgres.rule=HostSNI(`postgres.jabed.dev`)` - Define the domain for TCP routing
- `traefik.tcp.routers.postgres.entrypoints=postgres` - Use the PostgreSQL entrypoint
- `traefik.tcp.services.postgres.loadbalancer.server.port=5432` - Define the internal PostgreSQL port


### Initial Setup

1. Copy `postgres.example.env` to `postgres.env` and fill in your desired values.
2. Edit `init.sql` if you want to change the default database/user creation.