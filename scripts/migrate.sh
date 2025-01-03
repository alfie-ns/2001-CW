#!/bin/bash

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# change to the Django project directory OR exit with failure
cd cw2/cw2_trailapi || exit 1

if python3 manage.py makemigrations; then
    print_bold "Migrating..."
    python3 manage.py migrate
    print_bold "Migration successful"
else
    print_bold "Migration failed..."
fi