#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

rm *.json
rm *.pem
rm *.csr

sh ca.sh
sh admin.sh
sh controllers.sh
sh workers.sh

sh kubernetes.sh
sh kube-controller-manager.sh
sh kube-scheduler.sh
sh kube-proxy.sh

sh service-account.sh