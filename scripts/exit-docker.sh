#!/bin/bash
if docker stop COMP2001sqlserv; then
    echo "Exiting Docker gracefully"
else
    echo "Failed to exit Docker gracefully"
fi