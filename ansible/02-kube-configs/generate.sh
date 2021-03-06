#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

export CERT_DIR=../01-certificates

rm *.kubeconfig

sh workers.sh
sh admin.sh
sh kube-controller-manager.sh
sh kube-proxy.sh
sh kube-scheduler.sh