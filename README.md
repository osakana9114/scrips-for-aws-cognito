# scrips-for-aws-cognito
AWS CLIを使用して、AWS Cognitoユーザープール内のアカウントを操作するスクリプトです。

Scripts which manages accounts in AWS Cognito User Pool with AWS CLI.

　
## 共通仕様
以下の変数に対象環境のものを設定します。  
- `POOL_ID` = ユーザープールID
- `PROFILE` = AWS CLIのprofile

## list-cognito-users
[ListUsers](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_ListUsers.html) でユーザーの一覧を取得し、tsvファイルに出力します。

取得項目は必要に応じて変更します。
```
[.Username,.Attributes[].Value,.UserCreateDate,.UserLastModifiedDate]
```

## delete-cognito-users
[AdminDeleteUser](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminDeleteUser.html) でユーザーを削除します。

_list-cognito-users_ で出力したtsvファイル（ "Username" が一番目の項目になっているtsvファイル）を読み込むことで、指定したユーザーを一括で削除します。
