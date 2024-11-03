#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# run the setup script
./scripts/setup.sh 

# run migrations
./scripts/django-migrate.sh 

# start the Django server
echo "Starting Django server..."
./scripts/start-server.sh 