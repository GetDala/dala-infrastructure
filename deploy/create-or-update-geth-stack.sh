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
	echo "ETHStatsServer is not set, please enter ETHStatsServer"
	read -p 'ETHStatsServer:' ETHStatsServer
else
	ETHStatsServer="${6}"
fi
if [ -z ${7} ]; then
	echo "ETHStatsPassword is not set, please enter ETHStatsPassword"
	read -p 'ETHStatsPassword:' ETHStatsPassword
else
	ETHStatsPassword="${7}"
fi

if [ -z ${8} ]; then
	echo "InstanceType is not set, please enter InstanceType"
	read -p 'InstanceType:' InstanceType
else
	InstanceType="${8}"
fi

if [ -z ${9} ]; then
	echo "DockerImage is not set, please enter DockerImage"
	read -p 'DockerImage:' DockerImage
else
	DockerImage="${9}"
fi

if [ -z ${10} ]; then
	echo "SSHLocation is not set, please enter SSHLocation"
	read -p 'SSHLocation:' SSHLocation
else
	SSHLocation="${10}"
fi

if [ -z ${11} ]; then
	echo "InstanceCount is not set, please enter InstanceCount"
	read -p 'InstanceCount:' InstanceCount
else
	InstanceCount="${11}"
fi

echo "aws-profile is set to :" $awsprofile
echo "stack-name is set to :" $stackname
echo "region is set to :" $region
echo "key-pair is set to :" $keypair

node_modules/cfn-create-or-update/cli.js --profile "${awsprofile}" --region "${region}" create-stack --stack-name "${stackname}" --template-body file://CloudFormation/geth-stack.yml \
	--parameters ParameterKey=SSHLocation,ParameterValue="${SSHLocation}" \
	ParameterKey=KeyName,ParameterValue="${keypair}" \
	ParameterKey=DalaInfrastructureStackName,ParameterValue="${DalaInfrastructureStackName}" \
	ParameterKey=ETHStatsServer,ParameterValue="${ETHStatsServer}" \
	ParameterKey=ETHStatsPassword,ParameterValue="${ETHStatsPassword}" \
    ParameterKey=InstanceType,ParameterValue="${InstanceType}" \
    ParameterKey=DockerImage,ParameterValue="${DockerImage}" \
    ParameterKey=InstanceCount,ParameterValue="${InstanceCount}" \
	--capabilities CAPABILITY_IAM \
	--wait

RESULT=$?
if [ $RESULT -eq 0 ]; then
	echo "\n\n Stack: ${stackname} has been deployed \n\n"
else
	echo "\n\n Stack: ${stackname} did not successfully deploy"
fi
