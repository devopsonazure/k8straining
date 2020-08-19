## Kubernetes training demo scripts
Kubernetes training sample application and scripts, used in compaign with kubernetes training materials.

### Folder structure is listed in below
- azure-vote, this is our sample python application copied from [Azure Voting App](https://docs.microsoft.com/en-us/samples/azure-samples/azure-voting-app-redis/azure-voting-app/). Dockerfile is used to build azure-vote container image.
- deploy, contains terraform script to deploy a kubernetes cluster in Azure, to simulate a kubernetes on-premise cluster used in further demo.
- manifests, contains kubernetes object declarative yaml files, used to demo kubernetes objects, resource management and concepts. Script go.sh is used to deploy kubernetes resources under manifest folder. stress.sh is used to generate workload and demo HPA.
- policy, contains a simple yaml file to show how Azure policy works under Arc enabled kubernetes cluster.
- security, scripts and yaml files to demo security features in kubernetes.
- isolaion, contains script gen_ns_kubeconfig.sh which is used to demo how to limit access from service account to a namespace.

### Demo scenarios include
- Provision a kubernetes cluster with kubeadm (simulate an on-premise deployment)
- Kubernetes common resource introduction, like pod, deployment, statefulset, service, ingress, resource quota, limit, secret, configmap, node affinity, pod affinity, job and cronjob
- Horizontal pod autoscaler demo
- Container and kubernetes related security features, including contiainer level security(apparmor and seccomp), as well as pod security policy
- Kubernetes networking policy
- Kubernetes namespace isolation
- Nginx ingress controller
- Storage and PVC
- Azure policy for Arc enabled kubernetes
