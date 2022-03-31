pre_install:
	helm repo add jetstack https://charts.jetstack.io && \
    helm repo update && \
    helm install \
      cert-manager jetstack/cert-manager \
      --namespace cert-manager \
      --create-namespace \
      --version v1.7.2 \
      --set installCRDs=true

install:
	helm install release . --set database_url=$(DATABASE_URL)

upgrade:
	./upgrade.sh

rollback-0:
	helm rollback release 0
