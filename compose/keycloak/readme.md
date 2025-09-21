# Keycloak (OIDC)

OIDC service for internal services & applications.

---

### Environment Variables

| Name                     | Description                                                                 | Type     | Default Value          | Required |
|--------------------------|-----------------------------------------------------------------------------|----------|------------------------|----------|
| `KC_DB`                  | Database vendor (e.g., `postgres`, `mysql`, etc.)                          | string   | `postgres`             | Yes      |
| `KC_DB_URL`              | JDBC URL for the database connection                                        | string   | | `jdbc:postgresql://postgres:5432/keycloak` | Yes      |
| `KC_DB_USERNAME`         | Database username                                                          | string   |                        | Yes      |
| `         KC_DB_PASSWORD`         | Database password                                                          | string   |                        | Yes      |
| `KC_BOOTSTRAP_ADMIN_USERNAME` | Keycloak admin username                                                   | string   |                    | Yes      |
| `KC_BOOTSTRAP_ADMIN_PASSWORD` | Keycloak admin password                                                | string   |                    | Yes      |       
| `KC_HOSTNAME_URL`        | Public URL for Keycloak (used for redirects and links)                     | string   | `https://auth.jabed.dev` | Yes      |
| `KC_HOSTNAME_ADMIN_URL`  | Admin console URL (usually same as `KC_HOSTNAME_URL`)                      | string   | `https://auth.jabed.dev` | Yes     |
| `KEYCLOAK_FRONTEND_URL`  | Frontend URL for Keycloak  
| string   | `https://auth.jabed.dev` | Yes      |
| `KC_PROXY`               | Proxy mode (e.g., `edge`, `reencrypt`, `passthrough`)                     | string   | `edge`                 | No       |
| `KC_PROXY_ADDRESS_FORWARDING` | Enable address forwarding (true/false)                                 | boolean  | `true`                 | No       |
| `KC_HTTP_ENABLED`        | Enable HTTP (true/false)                                                   | boolean  | `true`                 | No       |
| ` KC_PROXY_HEADERS`        | Proxy headers to trust (comma-separated)                                   | string   | `xforwarded`           | No       |
| `KC_HEALTH_ENABLED`      | Enable health checks (true/false)                                          |       
| boolean  | `true`                 | No       |
| `KC_METRICS_ENABLED`     | Enable metrics (true/false)                                                | | boolean  | `true`                 | No       |
| `KC_LOG_LEVEL`           |       | Log level (e.g., `INFO`, `DEBUG`, `WARN`, `ERROR`)                            | string   | `INFO`                 | No       |
| `WEBHOOK_HTTP_BASE_PATH` | Webhook base URL for notifications                                          | string   |                        | No       |
| `WEBHOOK_HTTP_AUTH_USERNAME` | Webhook HTTP auth      username                                       | string   |                        | No       |         
| `WEBHOOK_HTTP_AUTH_PASSWORD` | Webhook HTTP auth password                                          | string   |                        | No       |

### Labels

- `traefik.enable=true` - Enable Traefik for this service
- `traefik.http.routers.keycloak.entrypoints=https` - Define entry points for the router
- `traefik.http.routers.keycloak.rule=Host(`auth.jabed.dev`)` - Define the routing rule based on the host
- `traefik.http.routers.keycloak.tls=true` - Enable TLS for the router
- `traefik.http.routers.keycloak.tls.certresolver=production` - Use the production certificate resolver
- `traefik.http.routers.keycloak.service=keycloak` - Define the service name for the router
- `traefik.http.services.keycloak.loadbalancer.server.port=8080` - Define the internal port for the service

### Initial Setup

Ensure you have a PostgreSQL database running and accessible. Create a database for Keycloak and set the appropriate environment variables for database connection. 

From the `plugins.bash` file, you can find a script to `curl` the plugins required for http-webhook functionality.