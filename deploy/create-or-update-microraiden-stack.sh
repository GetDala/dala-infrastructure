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
	echo "StackStage is not set, please enter StackStage"
	read -p 'StackStage:' StackStage
else
	StackStage="${6}"
fi
if [ -z ${7} ]; then
	echo "Environment is not set, please enter Environment"
	read -p 'Environment:' Environment
else
	Environment="${7}"
fi
if [ -z ${8} ]; then
	echo "RPCPROVIDER is not set, please enter RPCPROVIDER"
	read -p 'RPCPROVIDER:' RPCPROVIDER
else
	RPCPROVIDER="${8}"
fi

if [ -z ${9} ]; then
	echo "ChannelManagerAddress is not set, please enter ChannelManagerAddress"
	read -p 'ChannelManagerAddress:' ChannelManagerAddress
else
	ChannelManagerAddress="${9}"
fi

echo "aws-profile is set to :" $awsprofile
echo "stack-name is set to :" $stackname
echo "region is set to :" $region
echo "key-pair is set to :" $keypair

node_modules/cfn-create-or-update/cli.js --profile "${awsprofile}" --region "${region}" create-stack --stack-name "${stackname}" --template-body file://CloudFormation/microraiden-stack.yml \
	--parameters ParameterKey=StackRegion,ParameterValue="${region}" \
	ParameterKey=KeyPair,ParameterValue="${keypair}" \
	ParameterKey=DalaInfrastructureStackName,ParameterValue="${DalaInfrastructureStackName}" \
	ParameterKey=Environment,ParameterValue="${Environment}" \
	ParameterKey=StackStage,ParameterValue="${StackStage}" \
	ParameterKey=RPCPROVIDER,ParameterValue="${RPCPROVIDER}" \
	ParameterKey=ChannelManagerAddress,ParameterValue="${ChannelManagerAddress}" \
	--capabilities CAPABILITY_IAM \
	--wait

RESULT=$?
if [ $RESULT -eq 0 ]; then
	echo "\n\n Stack: ${stackname} has been deployed \n\n"
else
	echo "\n\n Stack: ${stackname} did not successfully deploy"
fi
