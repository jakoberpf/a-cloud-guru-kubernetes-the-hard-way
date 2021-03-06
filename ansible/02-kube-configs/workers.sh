#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for instance in ${WORKER0_HOST} ${WORKER1_HOST} ${WORKER2_HOST}; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=$CERT_DIR/ca.pem \
    --embed-certs=true \
    --server=https://${LB_INT_IP}:6443 \
    --kubeconfig=worker.${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=$CERT_DIR/worker.${instance}.pem \
    --client-key=$CERT_DIR/worker.${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=worker.${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=worker.${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=worker.${instance}.kubeconfig
done