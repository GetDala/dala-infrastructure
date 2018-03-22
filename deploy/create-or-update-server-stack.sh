echo "Deploying Dala-Fineract Stack"
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
	echo "fineract Database Username is not set, please enter fineract Database Username"
	read -p 'fineractDatabaseUsername:' fineractDatabaseUsername
else
	fineractDatabaseUsername="${4}"
fi

if [ -z ${5} ]; then
	echo "fineract Database Password is not set, please enter fineract Database Password"
	read -p 'fineractDatabasePassword:' fineractDatabasePassword
else
	fineractDatabasePassword="${5}"
fi

if [ -z ${6} ]; then
	echo "Dala Infrastructure Stack Name is not set, please enter Dala Infrastructure Stack Name "
	read -p 'DalaInfrastructureStackName:' DalaInfrastructureStackName
else
	DalaInfrastructureStackName="${6}"
fi

if [ -z ${7} ]; then
	echo "KeyPair is not set, please enter KeyPair name"
	read -p 'KeyPair:' KeyPair
else
	KeyPair="${7}"
fi

if [ -z ${8} ]; then
	echo "Storage Stack Name is not set, please enter Storage Stack Name "
	read -p 'StorageStackName:' StorageStackName
else
	StorageStackName="${8}"
fi

if [ -z ${9} ]; then
	echo "SSLCertificateARN is not set, please enter Storage Stack Name "
	read -p 'SSLCertificateARN:' SSLCertificateARN
else
	SSLCertificateARN="${9}"
fi

echo "aws-profile is set to :" $awsprofile
echo "stack-name is set to :" $stackname
echo "region is set to :" $region
echo "fineract Database Username is set to :" $fineractDatabaseUsername
echo "fineractDatabasePassword is set to :" $fineractDatabasePassword
echo "DalaInfrastructureStackName is set to :" $DalaInfrastructureStackName
echo "KeyPair is set to: " $KeyPair
echo "StorageStackName is set to: " $StorageStackName

node_modules/cfn-create-or-update/cli.js --profile "${awsprofile}" --region "${region}" create-stack --stack-name "${stackname}" --template-body file://CloudFormation/fineract-server-stack.yml \
	--parameters ParameterKey=StackRegion,ParameterValue="${region}" \
	ParameterKey=FineractDatabaseUsername,ParameterValue="${fineractDatabaseUsername}" \
	ParameterKey=FineractDatabasePassword,ParameterValue="${fineractDatabasePassword}" \
	ParameterKey=DalaInfrastructureStackName,ParameterValue="${DalaInfrastructureStackName}" \
    ParameterKey=KeyPair,ParameterValue="${KeyPair}" \
	ParameterKey=StorageStack,ParameterValue="${StorageStackName}" \
    ParameterKey=SSLCertificateARN,ParameterValue="${SSLCertificateARN}" \
	--capabilities CAPABILITY_IAM \
	--wait

RESULT=$?
if [ $RESULT -eq 0 ]; then
	echo "\n\n Stack: ${stackname} has been deployed \n\n"
else
	echo "\n\n Stack: ${stackname} did not successfully deploy"
fi
