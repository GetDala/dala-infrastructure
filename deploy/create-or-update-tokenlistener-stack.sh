#dalaorg/docker-geth-ropsten

echo "Deploying Dala-MicroRaiden Stack"
if [ -z ${1} ]; then
	echo "aws-profile is not set, please enter aws-profile name"
	read -p 'awsprofile:' awsprofile
else
	awsprofile="${1}"
fi
if [ -z ${2} ]; then
	echo "stack-name is not set, please enter stack-name name"
	read -p 'stackname:' stackname
else
	stackname="${2}"
fi

if [ -z ${3} ]; then
	echo "region is not set, please enter region"
	read -p 'region:' region
else
	region="${3}"
fi
if [ -z ${4} ]; then
	echo "key-pair is not set, please enter key-pair"
	read -p 'key-pair:' keypair
else
	keypair="${4}"
fi
if [ -z ${5} ]; then
	echo "DalaInfrastructureStackName is not set, please enter DalaInfrastructureStackName"
	read -p 'DalaInfrastructureStackName:' DalaInfrastructureStackName
else
	DalaInfrastructureStackName="${5}"
fi

if [ -z ${6} ]; then
	echo "TOKEN_ADDRESS is not set, please enter TOKEN_ADDRESS"
	read -p 'TOKEN_ADDRESS:' TOKEN_ADDRESS
else
	TOKEN_ADDRESS="${6}"
fi

if [ -z ${7} ]; then
	echo "RPCSERVER_INFURA is not set, please enter RPCSERVER_INFURA"
	read -p 'RPCSERVER_INFURA:' RPCSERVER_INFURA
else
	RPCSERVER_INFURA="${7}"
fi

if [ -z ${8} ]; then
	echo "RPCSERVER_PARITY is not set, please enter RPCSERVER_PARITY"
	read -p 'RPCSERVER_PARITY:' RPCSERVER_PARITY
else
	RPCSERVER_PARITY="${8}"
fi

echo "aws-profile is set to :" $awsprofile
echo "stack-name is set to :" $stackname
echo "region is set to :" $region
echo "key-pair is set to :" $keypair

node_modules/cfn-create-or-update/cli.js --profile "${awsprofile}" --region "${region}" create-stack --stack-name "${stackname}" --template-body file://CloudFormation/token-listener-stack.yml \
	--parameters ParameterKey=KeyPair,ParameterValue="${keypair}" \
	ParameterKey=DalaInfrastructureStackName,ParameterValue="${DalaInfrastructureStackName}" \
    ParameterKey=TOKENADDRESS,ParameterValue="${TOKEN_ADDRESS}" \
    ParameterKey=RPCSERVERINFURA,ParameterValue="${RPCSERVER_INFURA}" \
	ParameterKey=RPCSERVERPARITY,ParameterValue="${RPCSERVER_PARITY}" \
	--capabilities CAPABILITY_IAM \
	--wait

RESULT=$?
if [ $RESULT -eq 0 ]; then
	echo "\n\n Stack: ${stackname} has been deployed \n\n"
else
	echo "\n\n Stack: ${stackname} did not successfully deploy"
fi
