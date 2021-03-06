#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# Workers
scp worker1.kubeconfig kube-proxy.kubeconfig cloud_user@$WORKER1_HOST:~/
scp worker2.kubeconfig kube-proxy.kubeconfig cloud_user@$WORKER2_HOST:~/
scp worker3.kubeconfig kube-proxy.kubeconfig cloud_user@$WORKER3_HOST:~/

# Masters
scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig cloud_user@$MASTER1_HOST:~/
scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig cloud_user@$MASTER2_HOST:~/
scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig cloud_user@$MASTER3_HOST:~/