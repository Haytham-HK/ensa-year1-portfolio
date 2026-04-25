#!/bin/bash

# Configuration
ENDPOINT_URL="https://localhost.localstack.cloud:4566"
TEST_BUCKET_NAME="healthcheck-bucket-$(date +%s)"
AWS_OPTS="--endpoint-url=$ENDPOINT_URL --no-verify-ssl"

echo "--- LocalStack Health Check ---"

# 1. Check if LocalStack is reachable
if ! curl -k -s $ENDPOINT_URL/_localstack/health | grep -q '"s3": "running"'; then
    echo "❌ Error: LocalStack S3 service is not running or unreachable at $ENDPOINT_URL"
    exit 1
fi
echo "✅ LocalStack S3 is running."

# 2. Test S3 Bucket Creation
echo "Testing S3 bucket creation..."
if aws $AWS_OPTS s3 mb s3://$TEST_BUCKET_NAME > /dev/null 2>&1; then
    echo "✅ Successfully created test bucket: $TEST_BUCKET_NAME"
else
    echo "❌ Failed to create test bucket."
    exit 1
fi

# 3. Clean up
echo "Cleaning up..."
aws $AWS_OPTS s3 rb s3://$TEST_BUCKET_NAME > /dev/null 2>&1
echo "✅ Health check complete."
