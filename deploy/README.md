## Steps to deploy kubernetes cluster

- Run following commands to create a service principal
```sh
SUBSCRIPTION=<YOUR SUBSCRIPTION>
az login
az account set -s $SUBSCRIPTION
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION"
```
- Record the output from last step, replace aad_client_id in file terrform.tfvars with appId, and aad_client_secret in file terraform.tfvars with password
- Edit terraform.tfvars, specify username and password
- Download and install terrafrom from https://www.terraform.io/downloads.html
- Run following commands to provision a kubernetes cluster
```sh
terraform init
terraform apply
```
- Wait for 10 - 15mins, then use username and password specified, logon to the public IP(output from terraform)
- Run `kubeadm token list` to get the token from kubeadm, note down the token, for example `v9dkpx.qiherurm6l5p21b7`
- Run below commands to join agent nodes to kubernetes cluster, by default, there are two agent nodes,k8str-01 and k8str-02, so need to repeat same commands twice.
```sh
ssh azadmin@k8str-01
sudo vi /etc/kubernetes/kubeadm.yaml
# Replace REPLACE_ME with the token output from kubeadm token list
sudo kubeadm join --config /etc/kubernetes/kubeadm.yaml
```
- Run `kubectl apply -f https://docs.projectcalico.org/manifests/canal.yaml` to provision networking CNI, we use calico canal here.
- Run `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml` to install metrics server, which will be used for HPA example.
