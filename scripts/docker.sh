#!/bin/bash
CONTAINER_NAME="COMP2001sqlserv"
SQL_PASSWORD="C0mp2001!"

# Function to print bold text
print_bold() {
    echo -e "\033[1m$1\033[0m"
}

start_container() {
    print_bold "Starting SQL Server container..."
    docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=$SQL_PASSWORD" \
    -p 1433:1433 --name $CONTAINER_NAME -d \
    mcr.microsoft.com/azure-sql-edge
    print_bold "Container started."
}

stop_container() {
    print_bold "Stopping SQL Server container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    print_bold "Container stopped and removed."
}

case "$1" in
    start)
        if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
            print_bold "Container is already running."
        else
            start_container
        fi
        ;;
    stop)
        if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
            stop_container
        else
            print_bold "Container is not running."
        fi
        ;;
    restart)
        if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
            stop_container
        fi
        start_container
        ;;
    *)
        print_bold "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0

# To turn on: ./docker.sh start