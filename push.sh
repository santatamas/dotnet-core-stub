#!/usr/bin/env bash

configure_aws_cli(){
	aws --version
	aws configure set default.region eu-west-2
	aws configure set default.output json
}

push_ecr_image(){
    eval $(aws ecr get-login --region eu-west-2)
    docker push $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/sso-web:$CIRCLE_BUILD_NUM
    docker push $AWS_ACCOUNT_ID.dkr.ecr.eu-west-2.amazonaws.com/sso-api:$CIRCLE_BUILD_NUM
}

configure_aws_cli
push_ecr_image