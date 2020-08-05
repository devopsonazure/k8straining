NODES=(
    # The SSH-accessible domain names of your nodes
    k8sarc-00
    k8sarc-01
    k8sarc-02)
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