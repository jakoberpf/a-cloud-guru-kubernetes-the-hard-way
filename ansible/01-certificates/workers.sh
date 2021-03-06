#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for instance in ${WORKER0_HOST} ${WORKER1_HOST} ${WORKER2_HOST}; do
cat > worker.${instance}-csr.json <<EOF
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
  -hostname=${WORKER0_INT_IP},${WORKER0_HOST},${WORKER0_HOST%%.*} \
  -profile=kubernetes \
  worker.${WORKER0_HOST}-csr.json | cfssljson -bare worker.${WORKER0_HOST}

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${WORKER1_INT_IP},${WORKER1_HOST},${WORKER1_HOST%%.*} \
  -profile=kubernetes \
  worker.${WORKER1_HOST}-csr.json | cfssljson -bare worker.${WORKER1_HOST}

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${WORKER2_INT_IP},${WORKER2_HOST},${WORKER2_HOST%%.*} \
  -profile=kubernetes \
  worker.${WORKER2_HOST}-csr.json | cfssljson -bare worker.${WORKER2_HOST}
