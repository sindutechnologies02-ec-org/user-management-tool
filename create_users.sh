#!/bin/bash

INPUT="users.csv"
LOGFILE="logs/user_creation.log"
mkdir -p logs
echo "User Creation Log - $(date)" > "$LOGFILE"

while IFS=',' read -r username group
do
    if [ "$username" == "username" ]; then
        continue
    fi

    if ! getent group "$group" > /dev/null 2>&1; then
        sudo groupadd "$group"
        echo "Group '$group' created." >> "$LOGFILE"
    fi

    if ! id "$username" > /dev/null 2>&1; then
        sudo useradd -m -g "$group" "$username"
        echo "User '$username' created and added to group '$group'." >> "$LOGFILE"
    else
        echo "User '$username' already exists." >> "$LOGFILE"
    fi
done < "$INPUT"

echo "Done. Log: logs/user_creation.log"

