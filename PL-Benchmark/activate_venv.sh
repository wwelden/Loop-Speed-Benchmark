#!/bin/bash

# Script to activate the Python virtual environment

# Get the absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if virtual environment exists
if [ ! -d "$SCRIPT_DIR/venv" ]; then
    echo "Virtual environment not found. Creating one..."
    python3 -m venv "$SCRIPT_DIR/venv"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create virtual environment."
        exit 1
    fi
fi

# Activate the virtual environment
source "$SCRIPT_DIR/venv/bin/activate"

echo "Python virtual environment activated."
echo "You can now run Python scripts with dependencies installed in the virtual environment."
echo "Type 'deactivate' to exit the virtual environment."

# Keep the shell open with the activated environment
exec "${SHELL}"
