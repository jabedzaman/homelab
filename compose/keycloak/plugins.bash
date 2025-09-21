# Replace <version> with the desired release version.

VERSION=0.9.1
curl -L -o keycloak-webhook-provider-core.jar https://github.com/vymalo/keycloak-webhook/releases/download/v${VERSION}/keycloak-webhook-provider-core-${VERSION}-all.jar;
curl -L -o keycloak-webhook-provider-http.jar https://github.com/vymalo/keycloak-webhook/releases/download/v${VERSION}/keycloak-webhook-provider-http-${VERSION}-all.jar;