#!/bin/sh
[ -e tmp/password ] && rm tmp/password
PASSWORD=$(aws ssm get-parameter --name '/dala-wallet-api/ropsten/HOT_WALLET_PASSWORD' --with-decryption  --region $AWS_DEFAULT_REGION --query "Parameter.Value" --output text)
echo "$PASSWORD" > /tmp/password
chmod 400 /tmp/password
cd /dala-wallet && python3 -m src.microraiden.dala_proxy --private-key /tmp/private_key.json  --private-key-password-file /tmp/password --rpc-provider $RPC_PROVIDER --state-file "./dala_raiden_proxy.db" --channel-manager-address $CHANNEL_MANAGER_ADDRESS start
