#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# check if venv exists
if [ ! -d "venv" ]; then
    print_bold "Creating new virtual environment..."
    python3 -m venv venv
    print_bold "Virtual environment created!"
else
    print_bold "Virtual environment already exists; proceeding straight to activation..."
    source ./venv/bin/activate
fi

echo "Virtual environment activated"

# run the setup script
./scripts/setup.sh 

# run migrations
./scripts/django-migrate.sh 

# start the Django server
echo "Starting Django server..."
./scripts/start-server.sh 