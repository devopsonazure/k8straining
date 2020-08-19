NODES=(
    # The SSH-accessible domain names of your nodes
    REPLACE_ME_NODE_0
    REPLACE_ME_NODE_1
    REPLACE_ME_NODE_2)
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