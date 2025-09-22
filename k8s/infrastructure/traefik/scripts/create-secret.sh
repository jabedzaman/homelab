kubectl create secret generic traefik-dashboard-htpasswd \                                   
  --from-file=users=infrastructure/traefik/htpasswd.txt \
  --namespace=traefik