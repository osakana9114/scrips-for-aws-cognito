#!/bin/bash

POOL_ID="USER_POOL_ID"
PROFILE="AWS_PROFILE_NAME"

while read line; do
  line=($line)

  aws cognito-idp admin-delete-user --user-pool-id $POOL_ID --username ${line[0]} --profile $PROFILE --region ap-northeast-1
  if test $? -eq 0 ; then
    echo "Deleted: ${line[0]}"
  else
    echo "[ERROR] ${line[0]}"
  fi

  echo "------------------"
done < cognito-users.tsv
