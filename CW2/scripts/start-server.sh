#!/bin/bash
source venv/bin/activate # activate virtual environment

# Function to print bold text
print_bold() {
    echo -e "\033[1m$1\033[0m"
}

if ./scripts/django-migrate.sh; then
    print_bold "Starting Django server..."
    cd cw2_trailapi # change directory to django project
    python3 manage.py runserver # start django server if migration successful
else
    print_bold "Django server failed to migrate thus start..."
fi