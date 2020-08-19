NODES=(
    # The SSH-accessible domain names of your nodes
    REPLACE_ME_NODE_0
    REPLACE_ME_NODE_1
    REPLACE_ME_NODE_2)
for NODE in ${NODES[*]}; do ssh $NODE 'sudo apparmor_parser -q <<EOF
#include <tunables/global>

profile apparmor-deny-write flags=(attach_disconnected) {
  #include <abstractions/base>

  file,

  # Deny all file writes.
  deny /** w,
}
EOF'
done