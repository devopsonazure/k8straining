# kubectl run -i --tty busybox --image=busybox /bin/sh -n k8straining
# while true; do wget -q -O- http://vote; done
while true; do wget -q -O- http://vote.k8s.devsecops.ink; done
