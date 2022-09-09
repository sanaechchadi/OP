#!/bin/bash

for res in $(kubectl get statefulset -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete statefulset $res --cascade=false
done

for res in $(kubectl get replicaset -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete replicaset $res --cascade=false
done

for res in $(kubectl get deployment -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete deployment $res --cascade=false
done

for res in $(kubectl get service -n openstack2 | grep -v "^NAME" | grep -v "^kubernetes" | awk '{print $1}')
do
    kubectl delete service $res
done

for res in $(kubectl get pods -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete pod $res --grace-period=0 --force
done

for res in $(kubectl get configmaps -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete configmap $res
done

for res in $(kubectl get secret -n openstack2 | grep -v "^NAME" | grep -v "^default-token" | awk '{print $1}')
do
    kubectl delete secret $res
done

for res in $(kubectl get pdb -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete pdb $res
done
    
for res in $(kubectl get replicaset -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete replicaset $res --cascade=false
done

for res in $(kubectl get pods -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete pod $res --grace-period=0 --force
done
