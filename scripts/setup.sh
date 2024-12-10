#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# change to the Django project directory
cd cw2/cw2_trailapi || exit 1

# check if venv exists
if [ ! -d "venv" ]; then
    print_bold "Creating new virtual environment..."
    python3 -m venv venv
    print_bold "Virtual environment created!"
else
    print_bold "Virtual environment already exists..."
fi

# activate virtual environment
print_bold "Activating virtual environment..."
source venv/bin/activate

# install requirements
print_bold "Installing requirements..."
if pip install -r requirements.txt && pip install --upgrade pip; then
    print_bold "Requirements installed successfully"
else
    print_bold "Failed to install requirements"
fi