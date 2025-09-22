kubectl create secret generic cloudflare-api-token \
  --from-file=api-token=infrastructure/cert-manager/token.txt \
  --namespace cert-manager