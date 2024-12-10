#!/bin/bash
source venv/bin/activate
# Function to print bold text
print_bold() {
    echo -e "\033[1m$1\033[0m"
}
cd cw2_trailapi
if python3 manage.py makemigrations; then
    print_bold "Migrating..."
    python3 manage.py migrate
    print_bold "Migration successful"
else
    print_bold "Migration failed..."
fi