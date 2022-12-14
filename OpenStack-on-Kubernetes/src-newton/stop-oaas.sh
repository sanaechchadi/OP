#!/bin/bash

if [ "$1" != "--force" ]; then

    ./reset-zookeeper.sh
    ./reset-nova-compute.sh
    ./reset-nova-server.sh
    ./reset-neutron-server.sh
    ./reset-horizon.sh
    ./reset-cinder.sh
    ./reset-glance.sh
    ./reset-keystone.sh
    ./reset-haproxy.sh
    ./reset-rabbitmq.sh
    ./reset-mongodb.sh
    ./reset-memcached.sh
    ./reset-galera.sh
    ./reset-galera-etcd.sh
    
    #for pod in $(kubectl get all | awk '/^pod/ {print $1}'); do kubectl delete $pod --grace-period=0 --force; done
    
    kubectl delete configmap env-common
    kubectl delete configmap keystone-setup
    kubectl delete configmap glance-setup
    kubectl delete configmap cinder-setup
    kubectl delete configmap neutron-server-setup
    kubectl delete configmap nova-server-setup
    kubectl delete configmap nova-compute-setup
    kubectl delete configmap horizon-setup
    
    kubectl delete secret keystone-fernet-keys
    #kubectl delete secret mongodb-secret
    kubectl delete secret rabbitmq-erlang-cookie
    
    sleep 10
    
    ./reset-all-pv-pvc.sh
else
    for res in $(kubectl get statefulset | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete statefulset $res --cascade=false
    done
    
    for res in $(kubectl get replicaset | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete replicaset $res --cascade=false
    done
    
    for res in $(kubectl get deployment | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete deployment $res --cascade=false
    done
    
    for res in $(kubectl get service | grep -v "^NAME" | grep -v "^kubernetes" | awk '{print $1}')
    do
        kubectl delete service $res
    done
    
    for res in $(kubectl get pod | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete pod $res --grace-period=0 --force
    done
    
    for res in $(kubectl get configmap | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete configmap $res
    done
    
    for res in $(kubectl get secret | grep -v "^NAME" | grep -v "^default-token" | awk '{print $1}')
    do
        kubectl delete secret $res
    done
    
    for res in $(kubectl get pdb | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete pdb $res
    done
    
    for res in $(kubectl get pvc | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete pvc $res
    done
    
    for res in $(kubectl get pv | grep -v "^NAME" | awk '{print $1}')
    do
        kubectl delete pv $res
    done
fi

kubectl label nodes k8s-node01 controller- network-
kubectl label nodes k8s-node02 controller- network-
kubectl label nodes k8s-node03 controller- network-
kubectl label nodes k8s-node04 nfs-server- compute-
