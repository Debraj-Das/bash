#!/usr/bin/env bash

# Script to create a directory, navigate into it, and execute a Python script.

# Set -euo pipefail:  Exit immediately if a command exits with a non-zero status.
# -e: Exit if a command exits with a non-zero status.
# -u: Treat unset variables as an error.
# -o pipefail:  If a command in a pipeline fails, the whole pipeline fails.
set -euo pipefail

# Define the Python script path as a constant.  This makes it easy to change.
readonly PYTHON_SCRIPT="$HOME/.config/bash/scripts/cp/cphelper.py"

# Check if the Python script exists.
if [ ! -f "$PYTHON_SCRIPT" ]; then
	echo "Error: Python script '$PYTHON_SCRIPT' not found." >&2
	exit 1
fi

# Execute the Python script.
python "$PYTHON_SCRIPT"

exit 0 # Explicitly exit with success status.
