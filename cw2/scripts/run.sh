#!/bin/bash

# check if venv exists
if [ ! -d "venv" ]; then
    print_bold "Creating new virtual environment..."
    python3 -m venv venv
    print_bold "Virtual environment created!"
else
    print_bold "Virtual environment already exists; proceeding straight to activation..."
    source ./venv/bin/activate || echo "Failed to activate virtual environment"; exit 1;
fi

echo "Virtual environment activated"

# run the setup script
./scripts/setup.sh || echo "Setup failed"; exit 1; 

# run migrations
./scripts/django-migrate.sh || echo "Migration failed"; exit 1; 

# start the Django server
echo "Starting Django server..."
./scripts/start-server.sh || echo "Failed to start Django server"; exit 1;