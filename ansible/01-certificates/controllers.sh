#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for instance in ${MASTER0_HOST} ${MASTER1_HOST} ${MASTER2_HOST}; do
cat > controller.${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "DE",
      "L": "Munich",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Bavaria"
    }
  ]
}
EOF
done

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${MASTER0_INT_IP},${MASTER0_HOST} \
  -profile=kubernetes \
  controller.${MASTER0_HOST}-csr.json | cfssljson -bare controller.${MASTER0_HOST}

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${MASTER1_INT_IP},${MASTER1_HOST} \
  -profile=kubernetes \
  controller.${MASTER1_HOST}-csr.json | cfssljson -bare controller.${MASTER1_HOST}

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${MASTER2_INT_IP},${MASTER2_HOST} \
  -profile=kubernetes \
  controller.${MASTER2_HOST}-csr.json | cfssljson -bare controller.${MASTER2_HOST}
