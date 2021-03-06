#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# Masters
scp encryption-config.yaml cloud_user@$MASTER1_HOST:~/
scp encryption-config.yaml cloud_user@$MASTER2_HOST:~/
scp encryption-config.yaml cloud_user@$MASTER3_HOST:~/