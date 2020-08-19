## Steps to generate a service account who only has access to a namespace

- Run `./gen_ns_kubeconfig.sh <serviceaccount> <namespace>`, for example `./gen_ns_kubeconfig.sh k8suser k8straining`
- The service acount create will only have permission to access namespace k8straining, for example run `KUBECONFIG=k8s-k8suser-k8straining-conf kubectl get pods -n k8straining` will success, but run `KUBECONFIG=k8s-k8suser-k8straining-conf kubectl get pods -n k8straining -A` will get failed.
