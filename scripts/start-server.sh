#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# ensure we're in the Django project directory
cd cw2/cw2_trailapi || exit 1

source venv/bin/activate # activate the venv in the root directory

# 1- build the Docker image
print_bold "Building Docker image..."
docker build -t trail-api .

if [ $? -eq 0 ]; then
    print_bold "\nDocker image built successfully"
else
    print_bold "\nDocker image build failed"
    exit 1
fi

# 2- start Django development server
print_bold "\nStarting Django development server...\n"
python3 manage.py runserver 0.0.0.0:8000