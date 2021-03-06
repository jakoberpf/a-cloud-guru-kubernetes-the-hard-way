#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

{

KUBERNETES_PUBLIC_ADDRESS=$MASTER0_INT_IP,$MASTER1_INT_IP,$MASTER2_INT_IP,$MASTER0_HOST,$MASTER1_HOST,$MASTER2_HOST,$LB_INT_IP,$LB_HOST

KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local

cat > kubernetes-csr.json <<EOF
{
  "CN": "system:kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "DE",
      "L": "Munich",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Bavaria"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes

}