#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# ensure in the Django project directory or exit with failure
cd cw2/cw2_trailapi || exit 1

source venv/bin/activate # activate the venv in the root directory

# start Django development server
print_bold "\nStarting Django development server...\n"
python3 manage.py runserver 0.0.0.0:8000