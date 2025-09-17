# Traefik (Proxy)

Reverse proxy and load balancer for the homelab, with automatic HTTPS + wildcard certificates.

---

The configuration is done via environment variables along with adding labels to the services you want to expose.

<!-- table showing environment variables -->

### Environment Variables

| Variable               | Description                                                                 | Default Value          |
|------------------------|-----------------------------------------------------------------------------|------------------------|
| `CF_API_EMAIL`       | Email address associated with your Cloudflare account                       | `hi@jabed.dev`         |
|  `CF_API_KEY`         | Your Cloudflare API key (can be found in your Cloudflare dashboard)        | `""`                   |

---

### Labels

- `traefik.enable=true` - Enable Traefik for this service
- `traefik.http.routers.<router_name>.rule=Host(`<your-domain>)` - Define the domain for the service
- `traefik.http.routers.<router_name>.entrypoints=websecure` - Use the secure entrypoint (HTTPS)
- `traefik.http.routers.<router_name>.tls.certresolver=myresolver` - Use the defined certificate resolver
- `traefik.http.services.<service_name>.loadbalancer.server.port=<container_port>` - Define the internal port of the service
- `traefik.docker.network=web` - Specify the Docker network Traefik should use (if different from default)

### Initial Setup

1. Copy `traefik.example.env` to `traefik.env` and fill in your Cloudflare API key.
2. Make required directories:
   ```bash
   mkdir -p certs logs config users
   ```
3. Change ownership for certs directory:
   ```bash
   chmod 600 certs
   ```
4. Setup admin user
   ```bash
   htpasswd -c users/users admin
   ```

   