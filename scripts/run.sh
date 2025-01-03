#!/bin/bash
clear

print_bold() {
    echo -e "\033[1m$1\033[0m"
}
./scripts/django-migrate.sh

# check if Docker image DOESN'T exists
if ! docker images | grep -q trail-api; then
    print_bold "Docker image not found. Building..."
    docker build -t trail-api .
else
    print_bold "Docker image found"
fi

# check if the server is running on port 8000; -i flag checks for internet addresses
if lsof -i:8000 > /dev/null; then
    print_bold "Django Server already running..."
    open -a "Google Chrome" http://127.0.0.1:8000/api/trails/manage/
else
    if cd cw2/cw2_trailapi && python3 manage.py runserver; then
        print_bold "Django Server started successfully..."
        open -a "Google Chrome" http://127.0.0.1:8000/api/trails/manage/
    else
        print_bold "Django Server failed to start."
    fi
fi
