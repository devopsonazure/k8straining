VOTE_HOST=$(kubectl -n nginx-ingress get service nginx-ingress-controller | tail -n 1 | awk '{ print $4; }').xip.io
sed 's/vote-host.xip.io/'$VOTE_HOST'/g' -i stress.sh
sed 's/vote-host.xip.io/'$VOTE_HOST'/g' -i ingress.yml
sed 's/vote-host.xip.io/'$VOTE_HOST'/g' -i job.yml
sed 's/vote-host.xip.io/'$VOTE_HOST'/g' -i cronjob.yml
kubectl create ns k8straining
kubectl apply -f storageclass.yml
kubectl apply -f . 
echo ""
echo "application is running at: http://$VOTE_HOST"
