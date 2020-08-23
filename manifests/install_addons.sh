#!/usr/bin/env bash

ADDON_FILES=(
  namespace.yml
  resourcequota.yml
  limitrange.yml
  secret.yml
  configmap.yml
  service.yml
  deployment.yml
  statefulset.yml
  ingress.yml
  networkpolicy.yml
  hpa.yml
  job.yml
  cronjob.yml
)

ADDON_FILENAME=10_all_in_one.yml

# VOTE_HOST=$(kubectl -n nginx-ingress get service nginx-ingress-controller | tail -n 1 | awk '{ print $4; }').xip.io
VOTE_HOST=vote.k8s.devsecops.ink

function generate_addon_list() {
  local -r resources=( "$@" )
  echo "# Addon files" > $ADDON_FILENAME
  for resource in "${resources[@]}"; do
    # Check if $resource isn't composed just of whitespaces by replacing ' '
    # with '' and checking whether the resulting string is not empty.
    if [[ -n "${resource// /}" ]]; then
      cat "${resource}" >> $ADDON_FILENAME
      echo >> $ADDON_FILENAME
      echo "---" >> $ADDON_FILENAME
    fi
  done
}

generate_addon_list "${ADDON_FILES[@]}"
sed 's/vote-host.xip.io/'$VOTE_HOST'/g' -i $ADDON_FILENAME

cat >/etc/kubernetes/addons/00_system.yml <<EOF
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  labels:
    kubernetes.io/cluster-service: "true"
  name: azurefile
parameters:
  skuName: Standard_LRS
provisioner: kubernetes.io/azure-file
reclaimPolicy: Delete
volumeBindingMode: Immediate
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  labels:
    kubernetes.io/cluster-service: "true"
  name: azurefile-premium
parameters:
  skuName: Premium_LRS
provisioner: kubernetes.io/azure-file
reclaimPolicy: Delete
volumeBindingMode: Immediate
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    storageclass.beta.kubernetes.io/is-default-class: "true"
  labels:
    kubernetes.io/cluster-service: "true"
  name: default
parameters:
  cachingmode: ReadOnly
  kind: Managed
  storageaccounttype: StandardSSD_LRS
provisioner: kubernetes.io/azure-disk
reclaimPolicy: Delete
volumeBindingMode: Immediate
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  labels:
    kubernetes.io/cluster-service: "true"
  name: managed-premium
parameters:
  cachingmode: ReadOnly
  kind: Managed
  storageaccounttype: Premium_LRS
provisioner: kubernetes.io/azure-disk
reclaimPolicy: Delete
volumeBindingMode: Immediate
EOF

cp $ADDON_FILENAME /etc/kubernetes/addons
rm $ADDON_FILENAME
