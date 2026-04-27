#!/bin/bash

# start.sh - Script to start the entire microservices architecture
set -e

# Get the script directory and cd to the root of the project
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"

echo "Starting Gestion-Incidents Microservices..."

# 1. Package Java services
echo "Packaging services (skipping tests)..."
# Target the correct services directory
for service in gestion-incidents/services/*/ ; do
    if [ -f "$service/pom.xml" ]; then
        service_name=$(basename "$service")
        echo "Packaging $service_name..."
        # Ensure mvnw is executable
        chmod +x "$service/mvnw"
        (cd "$service" && ./mvnw package -DskipTests -q) &
    fi
done

# Wait for all background packaging processes to finish
wait

# 2. Start Docker containers
echo "Starting Docker containers..."
# Run from the directory containing docker-compose.yml
cd gestion-incidents
docker compose up -d --build

# 3. Wait for core infrastructure services
echo "Waiting for services to initialize (approx 30s)..."
sleep 30

echo "--------------------------------------------------------"
echo "All services are starting up."
echo ""
echo " SERVICE URLS:"
echo "  Eureka:    http://localhost:8761"
echo "  Gateway:   http://localhost:8080"
echo "  Keycloak:  http://localhost:8180"
echo "  RabbitMQ:  http://localhost:15672"
echo "  MinIO:     http://localhost:9001"
echo ""
echo "  APPLICATIONS:"
echo "  Client App:      http://localhost:3000"
echo "  Admin Dashboard: http://localhost:3003"
echo ""
echo " LOGIN CREDENTIALS:"
echo "  Admin App:  admin / admin"
echo "  Client App: client / client"
echo "  Keycloak:   admin / admin"
echo "  RabbitMQ:   guest / guest"
echo "  MinIO:      minioadmin / minioadmin"
echo "--------------------------------------------------------"
echo "Use 'docker compose logs -f' inside 'gestion-incidents/' to monitor progress."
