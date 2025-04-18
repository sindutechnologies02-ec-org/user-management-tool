#!/bin/bash

FOLDER="/home/projects"
GROUP="developers"
PERMISSION="770"

mkdir -p "$FOLDER"
chown :$GROUP "$FOLDER"
chmod $PERMISSION "$FOLDER"

echo "$FOLDER is now owned by $GROUP with $PERMISSION permission"
