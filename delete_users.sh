#!/bin/bash

INPUT="users.csv"
LOGFILE="logs/user_deletion.log"
echo "User Deletion Log - $(date)" > "$LOGFILE"

while IFS=',' read -r username group
do
    if [ "$username" == "username" ]; then
        continue
    fi

    if id "$username" > /dev/null 2>&1; then
        userdel -r "$username"
        echo "User '$username' deleted." >> "$LOGFILE"
    else
        echo "User '$username' does not exist." >> "$LOGFILE"
    fi
done < "$INPUT"

echo "User deletion done. Log: logs/user_deletion.log"
