Time: 30 mins
Prerequisites: 
Complete Lab 1
Reference:
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## Steps:
- Logon to K8S Cluster ssh azadmin@<Public IP>
Username: azadmin
Password: AzureP@ssw0rd

- curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
- helm repo add stable https://kubernetes-charts.storage.googleapis.com
- helm repo update
- kubectl create ns nginx-ingress
- helm install nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.replicaCount=1 --set backend=http://backend-podcontroller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux --set controller.publishService.enabled=true -n nginx-ingress
- git clone https://github.com/devopsonazure/k8straining/
- cd k8straining
- ./go.sh
- kubectl get pod -n k8straining
- kubectl get deploy -n k8straining
- kubectl get statefulset -n k8straining
- kubectl get service -n k8straining
- kubectl get endpoint -n k8straining
- kubectl run buybox --image=busybox --restart=Always --limits=cpu=50m,memory=64Mi --requests=cpu=25m,memory=32Mi -n k8straining -o yaml --dry-run
- kubectl scale deploy/azure-vote-front --replicas=3 -n k8straining
- kubectl rollout history deploy/azure-vote-front -n k8straining
- kubectl rollout undo deploy/azure-vote-front --to-revision=1 -n k8straining 

