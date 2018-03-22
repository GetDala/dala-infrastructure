echo "Deploying Dala-Infrastructure Stack"
if [ -z ${1} ]; then
	echo "key-pair name not set, please enter key-pair name"
	read -p 'KeyPair:' KeyPairV
else
	KeyPairV="${1}"
fi
if [ -z ${2} ]; then
	echo "allowed-ip-address is not set, please enter allowed-ip-address name"
	read -p 'SSHAllowIPAddress:' SSHAllowIPAddress
else
	SSHAllowIPAddress="${2}"
fi

if [ -z ${3} ]; then
	echo "aws-profile is not set, please enter aws-profile name"
	read -p 'awsprofile:' awsprofile
else
	awsprofile="${3}"
fi
if [ -z ${4} ]; then
	echo "stack-name is not set, please enter stack-name name"
	read -p 'stackname:' stackname
else
	stackname="${4}"
fi

if [ -z ${5} ]; then
	echo "region is not set, please enter region"
	read -p 'region:' region
else
	region="${5}"
fi

echo "key-pair is set to :" $KeyPairV
echo "SSHAllowIPAddress is set to :" $SSHAllowIPAddress
echo "aws-profile is set to :" $awsprofile
echo "stack-name is set to :" $stackname
echo "region is set to :" $region

node_modules/cfn-create-or-update/cli.js --profile "${awsprofile}" --region ${region} create-stack --stack-name "${stackname}" --template-body file://CloudFormation/base-stack.yml \
	--parameters ParameterKey=KeyPair,ParameterValue="${KeyPairV}" \
	ParameterKey=SSHAllowIPAddress,ParameterValue="${SSHAllowIPAddress}" \
	ParameterKey=StackRegion,ParameterValue="${region}" \
	--capabilities CAPABILITY_IAM \
	--wait

RESULT=$?
if [ $RESULT -eq 0 ]; then
	echo "\n\n Stack: ${stackname} has been deployed \n\n"
else
	echo "\n\n Stack: ${stackname} did not successfully deploy"
fi
