#!bin/bash
velero restore create --from-backup $1 --include-resources=persistentvolumes && \
kubectl patch pv $2 -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'
kubectl patch pv $2 --type json -p '[{"op": "remove", "path": "/spec/claimRef"}]'
kubectl apply -f pvc.yaml