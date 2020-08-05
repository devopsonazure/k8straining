NODES=(
    # The SSH-accessible domain names of your nodes
    k8sarc-00
    k8sarc-01
    k8sarc-02)
for NODE in ${NODES[*]}; do ssh $NODE 'sudo mkdir -p /var/lib/kubelet/seccomp && cat << EOF | sudo tee -a /var/lib/kubelet/seccomp/prevent-chmod
{
  "defaultAction": "SCMP_ACT_ALLOW",
  "syscalls": [
    {
      "name": "chmod",
      "action": "SCMP_ACT_ERRNO"
    }
  ]
}
EOF'
done