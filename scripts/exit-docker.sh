#!/bin/bash
if docker stop COMP2001sqlserv; then
    echo "Exiting Docker gracefully"
    if osascript -e 'quit app "Docker"'; then
        echo "Docker closed"
    else
        echo "Failed to close Docker"
    fi
else
    echo "Failed to exit Docker gracefully"
fi