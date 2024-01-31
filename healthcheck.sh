#!/bin/bash

# Function to check Flask app
test_app() {
    echo "Checking if Flask app is up..."
    # Execute health check command for Flask app
    while true; do
        wget -qO- http://localhost:1338/ >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Flask app is healthy"
        else
            echo "Flask app is unhealthy"
            exit 1
        fi
        sleep 30
    done
}

# Function to check PostgreSQL connectivity
check_postgres() {
    echo "Checking PostgreSQL connectivity..."
    # Adjust the PostgreSQL connection parameters as needed
    pg_isready -h postgres-db -U postgres
    if [ $? -eq 0 ]; then
        echo "PostgreSQL is ready"
    else
        echo "PostgreSQL is not ready"
        exit 1
    fi
}

# Start Flask app and perform health checks
test_app &
check_postgres
