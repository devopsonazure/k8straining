PUBLIC_IP=$(kubectl -n nginx-ingress get service nginx-ingress-controller | tail -n 1 | awk '{ print $4; }').xip.io
sed 's/public-ip.xip.io/'$PUBLIC_IP'/g' -i stress.sh
sed 's/public-ip.xip.io/'$PUBLIC_IP'/g' -i manifests/ingress.yml
kubectl create ns k8straining
kubectl apply -f manifests/storageclass.yml
kubectl apply -f manifests/. 
echo ""
echo "application is running at: http://$PUBLIC_IP"
