#!/bin/bash
set -e
# change directory
cd ./infrastructure
# Package CloudFormation template
aws cloudformation package \
    --template-file main.yml \
    --s3-bucket ${S3_Bucket} \
    --output-template-file main.template

# deploy cloudformation template
aws cloudformation deploy \
    --template-file main.template \
    --stack-name "$ResourcePrefix-$EnvironmentName-infra-stack" \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        EnvironmentName=${EnvironmentName} \
        ResourcePrefix=${ResourcePrefix} \
        VPCCidr=${VPCCidr} \
        PrivateSubnetCIDRA=${PrivateSubnetCIDRA} \
        PrivateSubnetCIDRB=${PrivateSubnetCIDRB} \
        ComposerName=${ComposerName} \
        ProviderName=${ProviderName} \
        InteractiveClusterName=${InteractiveClusterName} \
        TargetGroupName=${TargetGroupName} \
        LoadBalancerName=${LoadBalancerName} \
        VpcOriginName=${VpcOriginName} \
    --no-fail-on-empty-changeset
