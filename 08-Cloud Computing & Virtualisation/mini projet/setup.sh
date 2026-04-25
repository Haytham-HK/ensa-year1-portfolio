#!/bin/bash

# --- Configuration ---
ENDPOINT_URL="https://localhost.localstack.cloud:4566"
USER_NAME="read-only-user"
ROLE_NAME="s3-readonly-role"
S3_POLICY_NAME="S3ReadOnlyPolicy"
ASSUME_ROLE_POLICY_NAME="AssumeS3ReadOnlyRolePolicy"
BUCKET_NAME="my-secure-bucket"
S3_POLICY_ARN="arn:aws:iam::000000000000:policy/$S3_POLICY_NAME"
ASSUME_ROLE_POLICY_ARN="arn:aws:iam::000000000000:policy/$ASSUME_ROLE_POLICY_NAME"

# AWS CLI options
AWS_OPTS="--endpoint-url=$ENDPOINT_URL --no-verify-ssl"

echo "--- Deleting existing IAM resources to ensure a clean setup ---"

# Detach policies from role and user
aws $AWS_OPTS iam detach-role-policy --role-name $ROLE_NAME --policy-arn $S3_POLICY_ARN >/dev/null 2>&1
aws $AWS_OPTS iam detach-user-policy --user-name $USER_NAME --policy-arn $ASSUME_ROLE_POLICY_ARN >/dev/null 2>&1

# Delete policies
aws $AWS_OPTS iam delete-policy --policy-arn $S3_POLICY_ARN >/dev/null 2>&1
aws $AWS_OPTS iam delete-policy --policy-arn $ASSUME_ROLE_POLICY_ARN >/dev/null 2>&1

# Delete role and user
aws $AWS_OPTS iam delete-role --role-name $ROLE_NAME >/dev/null 2>&1
# Delete access keys first
for key in $(aws $AWS_OPTS iam list-access-keys --user-name $USER_NAME --query 'AccessKeyMetadata[*].AccessKeyId' --output text 2>/dev/null); do
  aws $AWS_OPTS iam delete-access-key --user-name $USER_NAME --access-key-id $key
done
aws $AWS_OPTS iam delete-user --user-name $USER_NAME >/dev/null 2>&1

echo "--- Setting up IAM resources for LocalStack ---"

# 1. Create IAM User
echo "Step 1: Creating IAM user '$USER_NAME'..."
aws $AWS_OPTS iam create-user --user-name $USER_NAME

# 2. Create IAM Role with trust policy
echo "Step 2: Creating IAM role '$ROLE_NAME'..."
aws $AWS_OPTS iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://assume-role-policy.json

# 3. Create and attach S3 read-only policy to the role
echo "Step 3: Creating and attaching '$S3_POLICY_NAME' to role '$ROLE_NAME'..."
aws $AWS_OPTS iam create-policy \
  --policy-name $S3_POLICY_NAME \
  --policy-document file://s3-role-permissions-policy.json
aws $AWS_OPTS iam attach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn $S3_POLICY_ARN

# 4. Create and attach policy to user to allow assuming the role
echo "Step 4: Creating and attaching '$ASSUME_ROLE_POLICY_NAME' to user '$USER_NAME'..."
aws $AWS_OPTS iam create-policy \
  --policy-name $ASSUME_ROLE_POLICY_NAME \
  --policy-document file://assume-s3-readonly-policy.json
aws $AWS_OPTS iam attach-user-policy \
  --user-name $USER_NAME \
  --policy-arn $ASSUME_ROLE_POLICY_ARN

# Generate Access Keys for the user
echo "Generating Access Keys for '$USER_NAME'..."
USER_CREDS=$(aws $AWS_OPTS iam create-access-key --user-name $USER_NAME)
ACCESS_KEY=$(echo $USER_CREDS | jq -r '.AccessKey.AccessKeyId')
SECRET_KEY=$(echo $USER_CREDS | jq -r '.AccessKey.SecretAccessKey')

echo "----------------------------------------------------"
echo "USER_ACCESS_KEY_ID=$ACCESS_KEY"
echo "USER_SECRET_ACCESS_KEY=$SECRET_KEY"
echo "----------------------------------------------------"

# Save to a temporary file for iam_test.sh
echo "export AWS_ACCESS_KEY_ID=$ACCESS_KEY" > .env.credentials
echo "export AWS_SECRET_ACCESS_KEY=$SECRET_KEY" >> .env.credentials
chmod 600 .env.credentials

# 5. Create the S3 bucket
echo "Step 5: Creating S3 bucket '$BUCKET_NAME'..."
aws $AWS_OPTS s3 mb "s3://$BUCKET_NAME" >/dev/null 2>&1

echo ""
echo "--- IAM and S3 setup complete! ---"
echo "You can now run the iam_test.sh script."
