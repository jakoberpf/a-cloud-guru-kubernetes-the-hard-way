#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=$CERT_DIR/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=$CERT_DIR/admin.pem \
    --client-key=$CERT_DIR/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=$CERT_DIR/ca.pem \
    --embed-certs=true \
    --server=https://$LB_HOST:6443 \
    --kubeconfig=remote.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=$CERT_DIR/admin.pem \
    --client-key=$CERT_DIR/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=remote.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=remote.kubeconfig

  kubectl config use-context default --kubeconfig=remote.kubeconfig
}