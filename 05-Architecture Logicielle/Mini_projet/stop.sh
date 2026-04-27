#!/bin/bash

# stop.sh - Script to stop the microservices architecture

echo "Stopping Gestion-Incidents Microservices..."
cd gestion-incidents
docker compose down

echo "Architecture stopped."
