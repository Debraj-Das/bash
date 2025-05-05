#!/usr/bin/env bash


# Set -euo pipefail:  Exit immediately if a command exits with a non-zero status.
# -e: Exit if a command exits with a non-zero status.
# -u: Treat unset variables as an error.
# -o pipefail:  If a command in a pipeline fails, the whole pipeline fails.
set -euo pipefail

sudo apt update
sudo apt upgrade


# for alarm.sh and run *.mp3 audio songs
sudo apt install mpg123



exit 0
