## Demo kubernetes security features

### Preparation
Open apparmor.sh and seccomp.sh, replace REPLACE_ME_NODE_0, REPLACE_ME_NODE_1 and REPLACE_ME_NODE_2 with real kubernetes node hostname, you can get those hostnames from `kubectl get node`, those hostnames will be listed under NAME column.

### AppArmor
- Run script `.\apparmor.sh` to create a deny write profile.
- Run `kubectl apply -f apparmor.yml` to create a pod and associate apparmor profile to it.
- Run `kubectl exec -it apparmor -- /bin/sh` to launch a shell within the pod we just created, now run `touch /tmp/test.txt`, it will get failed because the container is associated a deny write profile.

### Seccomp
- Run script `.\seccomp.sh` to create a profile which will deny chmod call.
- Run `kubectl apply -f seccomp.yml` to create a pod.
- The pod will call chmod command in its startup command, as it is denied in our seccomp profile, so pod won't be created successfully.
