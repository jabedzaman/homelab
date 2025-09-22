helm repo add traefik https://helm.traefik.io/traefik
helm repo update

helm install traefik traefik/traefik --namespace traefik -f infrastructure/traefik/values.yaml
