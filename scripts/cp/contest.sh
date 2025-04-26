#!/usr/bin/env bash

# Script to create a directory, navigate into it, and execute a Python script.

# Set -euo pipefail:  Exit immediately if a command exits with a non-zero status.
# -e: Exit if a command exits with a non-zero status.
# -u: Treat unset variables as an error.
# -o pipefail:  If a command in a pipeline fails, the whole pipeline fails.
set -euo pipefail

# Define the Python script path as a constant.  This makes it easy to change.
readonly PYTHON_SCRIPT="$HOME/.config/bash/scripts/cp/cphelper.py"

# Get folder name from user input.
read -r -p "Enter new directory name: " directory

# Validate the folder name.  This is crucial to prevent unexpected behavior.
if [[ ! "$directory" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "Error: Invalid folder name.  Only alphanumeric characters, underscores, and hyphens are allowed." >&2
  exit 1
fi

# Create the directory.  The -p option creates parent directories if needed.
mkdir -p "$directory"

# Check if the directory was created successfully.
if [ ! -d "$directory" ]; then
  echo "Error: Failed to create directory '$directory'." >&2
  exit 1
fi

# Navigate to the directory.
cd "$directory"

# Check if the directory was changed successfully.
if [ "$(pwd)" != "$(realpath "$directory")" ]; then
  echo "Error: Failed to change to directory '$directory'." >&2
  exit 1
fi

# Check if the Python script exists.
if [ ! -f "$PYTHON_SCRIPT" ]; then
  echo "Error: Python script '$PYTHON_SCRIPT' not found." >&2
  exit 1
fi

# Execute the Python script.
python "$PYTHON_SCRIPT"

# Check the exit status of the Python script.
# if [ "$?" -ne 0 ]; then
#   echo "Error: Python script '$PYTHON_SCRIPT' failed to execute." >&2
#   exit 1
# fi

echo "Successfully created directory '$directory', navigated into it, and executed '$PYTHON_SCRIPT'."
exit 0 # Explicitly exit with success status.
