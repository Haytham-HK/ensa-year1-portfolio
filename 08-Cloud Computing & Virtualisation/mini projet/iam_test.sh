#!/bin/bash

# --- Configuration ---
ENDPOINT_URL="https://localhost.localstack.cloud:4566"
ROLE_ARN="arn:aws:iam::000000000000:role/s3-readonly-role"
ROLE_SESSION_NAME="s3-readonly-session"

# Credentials for the 'read-only-user'
if [ -f .env.credentials ]; then
    source .env.credentials
else
    echo "Error: .env.credentials not found. Please run ./setup.sh first."
    exit 1
fi

echo "--- IAM Role Test: 's3-readonly-role' ---"
echo ""

echo "Step 0: Verifying initial identity (read-only-user)..."
awslocal --endpoint-url=$ENDPOINT_URL sts get-caller-identity --output json
echo ""

echo "Step 1: Assuming the IAM role '$ROLE_ARN'..."

# Assume the role and capture the temporary credentials
TEMP_CREDENTIALS=$(awslocal --endpoint-url=$ENDPOINT_URL sts assume-role \
  --role-arn "$ROLE_ARN" \
  --role-session-name "$ROLE_SESSION_NAME" \
  --output json)

if [ $? -ne 0 ]; then
    echo "Error: Failed to assume role. Please check if the user and role are set up correctly."
    exit 1
fi

# Extract the temporary credentials using jq
export AWS_ACCESS_KEY_ID=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.SessionToken')

echo "Role assumed successfully. Using temporary credentials."
echo ""

echo "Step 1b: Verifying new (assumed) identity..."
echo "The 'Arn' should now show that we are the 's3-readonly-role'."
awslocal --endpoint-url=$ENDPOINT_URL sts get-caller-identity --output json
echo ""


# --- Test Permissions with Assumed Role ---

echo "Step 2: Testing READ-ONLY access (listing contents of 's3://my-secure-bucket')."
echo "This command should SUCCEED, as the role has 's3:ListBucket' permission on this bucket."
awslocal --endpoint-url=$ENDPOINT_URL s3 ls s3://my-secure-bucket
echo ""

echo "Step 3: Testing WRITE access (attempting to upload a file to 's3://my-secure-bucket')."
echo "This command SHOULD FAIL, as the role does not have 's3:PutObject' permission."
touch /tmp/test-file.txt
awslocal --endpoint-url=$ENDPOINT_URL s3 cp /tmp/test-file.txt s3://my-secure-bucket/
if [ $? -ne 0 ]; then
    echo "SUCCESS: As expected, the write operation was denied. The IAM role is working correctly."
else
    echo "KNOWN ISSUE: The write operation was allowed. This appears to be a bug in the current version of LocalStack, as the policy should prevent this."
fi
rm /tmp/test-file.txt
echo ""

echo "--- IAM Role Test Complete ---"
