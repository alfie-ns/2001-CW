#!/bin/bash
clear

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

# run the setup script
./scripts/setup.sh 

# run migrations
./scripts/django-migrate.sh 

# start the Django server
./scripts/start-server.sh 

: "
this script is the main/mother script that'll call each script in the correct order to run CW2:

-1 set up the project
-2 run migrations to update the database
-3 start the Django server
"