#!/bin/bash

POOL_ID={USER_POOL_ID}
PROFILE={AWS_PROFILE_NAME}

while : ; do
  aws cognito-idp list-users --user-pool-id $POOL_ID --profile $PROFILE $tokenopt | tee tmp | jq -r '.Users[] | [.Username,.Attributes[].Value,.UserCreateDate,.UserLastModifiedDate] | @tsv' >> cognito-users.tsv
  token=`jq -r '.PaginationToken' tmp`
  if [ "$token" == "null" ]; then break; else tokenopt="--pagination-token $token"; fi
done

rm tmp
