#!/bin/bash
# stop.sh - Script to stop the Spring Boot application

PID_FILE="app.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    echo "Stopping application with PID $PID..."
    kill "$PID"
    rm "$PID_FILE"
    echo "Application stopped."
else
    # Fallback to process name search
    echo "PID file not found. Searching for running JAR..."
    PID=$(ps aux | grep 'campus-eco-0.0.1-SNAPSHOT.jar' | grep -v grep | awk '{print $2}')
    if [ -n "$PID" ]; then
        echo "Found PID $PID. Stopping..."
        kill "$PID"
        echo "Application stopped."
    else
        echo "No running application found."
    fi
fi
