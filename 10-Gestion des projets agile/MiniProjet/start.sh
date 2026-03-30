#!/bin/bash
# start.sh - Script to start the Spring Boot application

# Default user credentials
# User: etudiant@ensa.ac.ma
# Password: cyber123

JAR_NAME="target/campus-eco-0.0.1-SNAPSHOT.jar"
LOG_FILE="server.log"
PID_FILE="app.pid"
SITE_URL="http://localhost:8080"

# Build if the JAR is missing
if [ ! -f "$JAR_NAME" ]; then
    echo "JAR file not found. Packaging the application..."
    mvn package -DskipTests
fi

# Check if already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null; then
        echo "Application is already running (PID: $PID)."
        exit 1
    else
        rm "$PID_FILE"
    fi
fi

echo "Starting Campus Eco Application..."
nohup java -jar "$JAR_NAME" > "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

echo "Application started with PID $(cat $PID_FILE)."
echo "You can check the logs with: tail -f $LOG_FILE"
echo ""
echo "Default User Credentials:"
echo "  Email: etudiant@ensa.ac.ma"
echo "  Password: cyber123"
echo ""
echo "Site URL: $SITE_URL"
echo ""
