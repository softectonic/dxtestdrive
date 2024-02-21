#!/bin/bash

# Define the path to your Python script
PYTHON_SCRIPT_PATH="scripts/replaceMetadataValues.py"

# Check if the Python script exists
if [ ! -f "$PYTHON_SCRIPT_PATH" ]; then
    echo "Python script not found at $PYTHON_SCRIPT_PATH"
    exit 1
fi

# Execute the Python script
python3 "$PYTHON_SCRIPT_PATH"

# Check the exit status of the Python script
if [ $? -eq 0 ]; then
    echo "XML values replacement completed successfully."
else
    echo "XML values replacement failed."
fi
