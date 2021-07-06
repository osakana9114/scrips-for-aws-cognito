#!/bin/bash

POOL_ID="USER_POOL_ID"
PROFILE="AWS_PROFILE_NAME"

while : ; do
  aws cognito-idp list-users --user-pool-id $POOL_ID --profile $PROFILE --region ap-northeast-1 $tokenopt --output json | tee tmp | jq -r '.Users[] | [.Username,.Attributes[].Value,.UserCreateDate,.UserLastModifiedDate] | @tsv' >> tsv/cognito-users_`date "+%Y%m%d_%H%M%S"`.tsv
  token=`jq -r '.PaginationToken' tmp`
  if [ "$token" == "null" ]; then break; else tokenopt="--pagination-token $token"; fi
done

rm tmp

## 検索条件 ##
# UserStatusが "FORCE_CHANGE_PASSWORD" のもの
# .Users[] | select(.UserStatus == "FORCE_CHANGE_PASSWORD") | [.Username,.Attributes[].Value,.UserCreateDate,.UserLastModifiedDate,.Enabled,.UserStatus] | @tsv

# Attributesから指定した項目のみ抽出
# .Users[] | [.Username,(.Attributes[] | select(.Name == "foo").Value)] | @tsv