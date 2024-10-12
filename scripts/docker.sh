#!/bin/bash

CONTAINER_NAME="COMP2001sqlserv"
SQL_PASSWORD="C0mp2001!"
IMAGE_NAME="mcr.microsoft.com/azure-sql-edge:latest"
BACKUP_DIR="./backups"

print_bold() {
    echo -e "\033[1m$1\033[0m"
}

cleanup() {
    print_bold "Cleaning up existing containers and volumes..."
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker volume prune -f
    print_bold "All containers and volumes have been removed."
}

start_container() {
    print_bold "Starting Azure SQL Edge container..."
    docker run -e "ACCEPT_EULA=1" \
               -e "MSSQL_SA_PASSWORD=$SQL_PASSWORD" \
               -e "MSSQL_PID=Developer" \
               -e "MSSQL_LCID=1033" \
               -e "MSSQL_COLLATION=SQL_Latin1_General_CP1_CI_AS" \
               -e "MSSQL_UPGRADE_MODE=None" \
               -p 1434:1433 \
               --name $CONTAINER_NAME \
               --cap-add SYS_PTRACE \
               -v sqlvolume:/var/opt/mssql \
               -d $IMAGE_NAME
    print_bold "Container started."
}

kill_container() {
    print_bold "Killing Azure SQL Edge container..."
    backup_database
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    print_bold "Container stopped and removed."
}

check_container_status() {
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        print_bold "Container is running."
        docker ps -f name=$CONTAINER_NAME
        docker port $CONTAINER_NAME
    elif [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
        print_bold "Container exists but is not running."
        print_bold "Container logs:"
        docker logs $CONTAINER_NAME
    else
        print_bold "Container does not exist."
    fi
}

backup_database() {
    print_bold "Backing up the database..."
    
    # Ensure backup directory exists
    mkdir -p $BACKUP_DIR
    
    # Generate a timestamp for the backup file
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.bak"
    
    # Run the backup command
    docker exec $CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd \
        -S localhost -U SA -P "$SQL_PASSWORD" \
        -Q "BACKUP DATABASE [master] TO DISK = N'/var/opt/mssql/data/master_backup.bak' WITH NOFORMAT, NOINIT, NAME = 'master-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"
    
    # Copy the backup file from the container to the host
    docker cp $CONTAINER_NAME:/var/opt/mssql/data/master_backup.bak $BACKUP_FILE
    
    if [ $? -eq 0 ]; then
        print_bold "Backup completed successfully. Backup file: $BACKUP_FILE"
    else
        print_bold "Backup failed. Please check the container logs for more information."
    fi
}


case "$1" in
    start)
        cleanup
        start_container
        ;;
    kill)
        kill_container
        ;;
    restart)
        kill_container
        start_container
        ;;
    status)
        check_container_status
        ;;
    cleanup)
        cleanup
        ;;
    backup)
        backup_database
        ;;
    *)
        print_bold "Usage: $0 {start|kill|restart|status|cleanup|backup}"
        exit 1
        ;;
esac

exit 0

cat << EOF

To startup the container, run:
    ./docker.sh start

To backup the database, run:
    ./docker.sh backup

To check the status of the container, run:
    ./docker.sh status

To stop and remove the container, run:
    ./docker.sh kill
    
To stop and remove all containers and volumes, run:
    ./docker.sh cleanup


EOF