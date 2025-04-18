#!/bin/bash

LOGFILE="/home/ec2-user/user-management-tool/logs/cleanup.log"

# Start the cleanup process and log it
echo "$(date) - Starting user cleanup process" >> "$LOGFILE"

# Loop through all inactive users (users with /usr/sbin/nologin shell)
for user in $(awk -F: '$7 == "/usr/sbin/nologin" {print $1}' /etc/passwd); do
    # Skip system users (those whose UID is less than 1000)
    if [ $(id -u $user) -lt 1000 ]; then
        echo "$(date) - Skipping system user: $user" >> "$LOGFILE"
        continue
    fi

    # Log the user deletion
    echo "$(date) - Deleting inactive user: $user" >> "$LOGFILE"
    userdel -r $user
done

# Log the cleanup completion
echo "$(date) - Cleanup process completed" >> "$LOGFILE"

