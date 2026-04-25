#!/bin/bash

# Start LocalStack services in detached mode
echo "Starting LocalStack services..."
docker-compose up -d

echo ""
echo "LocalStack is now running in the background."
echo ""
echo "Important Information:"
echo "--------------------------------------------------------------------------------"
echo "1. Access the LocalStack Web Application (Resource Browser) in your browser at:"
echo "   https://app.localstack.cloud"
echo ""
echo "2. Ensure the endpoint URL in the web app (if prompted) is set to:"
echo "   https://localhost.localstack.cloud:4566"
echo ""
echo "3. You can interact with LocalStack services using 'awslocal' commands."
echo "   Example: awslocal --endpoint-url=https://localhost.localstack.cloud:4566 s3 ls"
echo "--------------------------------------------------------------------------------"
echo ""
