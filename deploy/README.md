## Steps to deploy a kubernetes cluster through kubeadm

Deploy folder contains terraform script if you want to deploy a kubernetes cluster all by your own. Prerequisites is the user should be able to create an Azure AD service principal, you must have permissions to register an application with your Azure AD tenant, and to assign the application to a role in your subscription.

Provision steps are in below
- Run following commands to create a service principal
```sh
SUBSCRIPTION=<YOUR SUBSCRIPTION>
az login
az account set -s $SUBSCRIPTION
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION"
```
- Record the output from above step, replace 'aad_client_id' and 'aad_client_secret' in file terrform.tfvars with 'appId' and 'password' from above output
- Review terraform.tfvars, adjust other variables accordingly, for example username and password
- Download and install terrafrom by following instructions from https://www.terraform.io/downloads.html
- Run following commands to provision a kubernetes cluster
```sh
terraform init
terraform apply
```
- Wait for 10 - 15mins, then use username and password specified in terraform.tfvars, logon to the public IP(output from terraform deployment result)
- Run `kubeadm token list` to get the token from kubeadm, note down the token, for example `v9dkpx.qiherurm6l5p21b7`
- Logon to agent nodes by running 'ssh AGENT_NODE', run `sudo vi /etc/kubernetes/kubeadm.yml`, replace `REPLACE_ME` with the token listed from above step
- Join agent nodes to kubernetes cluster, by default, there are two agent nodes,k8str-01 and k8str-02, so need to repeat same commands twice.
```sh
ssh azadmin@k8str-01
sudo vi /etc/kubernetes/kubeadm.yaml
# Replace REPLACE_ME with the token output from kubeadm token list
sudo kubeadm join --config /etc/kubernetes/kubeadm.yaml
```
- Run `kubectl apply -f https://docs.projectcalico.org/manifests/canal.yaml` to provision networking CNI, we use calico canal here.
- Run `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml` to install metrics server, metrics server is required for HPA demo.
- Run below command to modify metrics server arguments
```sh
kubectl patch deployment \
  metrics-server \
  --namespace kube-system \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "--cert-dir=/tmp",
  "--secure-port=4443",
  "--kubelet-insecure-tls"
]}]'
```
