#!/bin/bash

# Function to print bold text
print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# Check if Docker container is running
if docker ps --filter "name=COMP2001sqlserv" --filter "status=running" | grep COMP2001sqlserv; then
    if docker stop COMP2001sqlserv; then
        print_bold "Docker exited gracefully"
    else
        print_bold "Failed to exit Docker"
    fi
else
    if docker start COMP2001sqlserv; then
        print_bold "Docker started successfully"
    else
        print_bold "Failed to start Docker"
    fi
fi