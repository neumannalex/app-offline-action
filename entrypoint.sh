#!/bin/sh

# "to avoid continuing when errors or undefined variables are present"
set -eu

echo "Starting App-Offline"

WDEFAULT_LOCAL_DIR=${LOCAL_DIR:-"."}
WDEFAULT_REMOTE_DIR=${REMOTE_DIR:-"."}
WDEFAULT_ARGS=${ARGS:-""}
WDEFAULT_METHOD=${METHOD:-"ftp"}

if [ $WDEFAULT_METHOD = "sftp" ]; then
  WDEFAULT_PORT=${PORT:-"22"}
  echo "Establishing SFTP connection..."
  sshpass -p $FTP_PASSWORD sftp -o StrictHostKeyChecking=no -P $WDEFAULT_PORT $FTP_USERNAME@$FTP_SERVER
  echo "Connection established"
else
  WDEFAULT_PORT=${PORT:-"21"}
fi;

echo "Using $WDEFAULT_METHOD to connect to port $WDEFAULT_PORT"

if [ $APP_STATE = "offline" ]; then
    echo "Creating app_offline.html"
    # todo: Datei erzeugen

    echo "Uploading app_offline.html"
    # todo: Datei hochladen

    # echo "Uploading files..."
    # lftp $WDEFAULT_METHOD://$FTP_SERVER:$WDEFAULT_PORT -u $FTP_USERNAME,$FTP_PASSWORD -e "set ftp:ssl-allow no; mirror $WDEFAULT_ARGS -R $WDEFAULT_LOCAL_DIR $WDEFAULT_REMOTE_DIR; quit"
else
    echo "Deleting app_offline.html"
    # todo: Datei löschen
fi;

echo "App-Offline Complete"
exit 0