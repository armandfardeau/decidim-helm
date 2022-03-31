export REDIS_PASSWORD=$(kubectl get secret --namespace "default" release-redis-cluster -o jsonpath="{.data.redis-password}" | base64 --decode)
echo $REDIS_PASSWORD
sleep 5
helm upgrade release . --set database_url=$DATABASE_URL --set password=$REDIS_PASSWORD