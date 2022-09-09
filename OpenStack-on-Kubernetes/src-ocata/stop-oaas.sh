#!/bin/bash

for res in $(kubectl get statefulset -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete statefulset $res --cascade=false
done

for res in $(kubectl get deployment -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete deployment $res --cascade=false
done

for res in $(kubectl get service -n openstack2 | grep -v "^NAME" | grep -v "^kubernetes" | awk '{print $1}')
do
    kubectl delete service $res
done

for res in $(kubectl get pods -n openstack2| grep -v "^NAME" | awk '{print $1}')
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
    
for res in $(kubectl get pvc -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete pvc $res
done
oc delete pv pv-ceilometer-gnocchi
oc delete pv pv-galera-galera-0
oc delete pv pv-galera-galera-1
oc delete pv pv-galera-galera-2
oc delete pv pv-glance-images
oc delete pv pv-mongodb-mongodb-0
oc delete pv pv-mongodb-mongodb-1
oc delete pv pv-mongodb-mongodb-2
oc delete pv pv-nfs-server
oc delete pv pv-rabbitmq-rabbitmq-0
oc delete pv pv-rabbitmq-rabbitmq-1
oc delete pv pv-rabbitmq-rabbitmq-2
oc delete pv pv-zookeeper-zk-0
oc delete pv pv-zookeeper-zk-1
oc delete pv pv-zookeeper-zk-2

for res in $(kubectl get replicaset -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete replicaset $res --cascade=false
done

for res in $(kubectl get pods -n openstack2 | grep -v "^NAME" | awk '{print $1}')
do
    kubectl delete pod $res --grace-period=0 --force
done

