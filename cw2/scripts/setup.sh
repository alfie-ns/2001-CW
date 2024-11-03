#!/bin/bash

# Function to print bold text
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
fi

# activate virtual environment
print_bold "Activating virtual environment..."
source venv/bin/activate

# complete
print_bold "Installing requirements..."
if pip install -r requirements.txt && pip install --upgrade pip; then
    print_bold "Requirements installed successfully"
    print_bold "Setup complete"
else
    print_bold "Failed to install requirements"
fi