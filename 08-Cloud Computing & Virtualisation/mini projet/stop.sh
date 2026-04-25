#!/bin/bash

echo "Stopping LocalStack services..."
docker-compose down --remove-orphans

echo "LocalStack services have been stopped."
