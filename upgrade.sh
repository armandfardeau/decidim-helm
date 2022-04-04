export REDIS_PASSWORD=$(kubectl get secret --namespace "default" release-redis-cluster -o jsonpath="{.data.redis-password}" | base64 --decode)
sleep 5
helm upgrade release . --set database_url=$DATABASE_URL --set password=$REDIS_PASSWORD --set ingress.hosts[0]=$HOST --set ingress.tls.hosts[0]=$HOST