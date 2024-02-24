#!/bin/bash

# This shell script serves as a wrapper for executing a Python-based search and replace operation. 
# It automates the process of modifying XML files based on rules defined in a YAML configuration file. 
# The script checks for the existence of the specified Python script and the YAML configuration file, 
# then executes the Python script, passing the path to the YAML configuration as an argument. 
# It concludes by reporting the success or failure of the XML values replacement operation.

# Export the TARGET_ENVIRONMENT variable to make it available globally
#export TARGET_ENVIRONMENT=$TARGET_ENVIRONMENT

# $1 package name
# $2 org
# $3 alias
# $4 working directory
# $5 package directory

echo "The TARGET_ENVIRONMENT is set to: $TARGET_ENVIRONMENT"

# Define the path to the Python script
PYTHON_SCRIPT_PATH="scripts/searchAndReplace.py"

# Define the path to the YAML configuration file (Corrected extension to .yml)
REPLACE_CONFIG_PATH="replace-config.yml"

# Check if the Python script exists
if [ ! -f "$PYTHON_SCRIPT_PATH" ]; then
    echo "Python script not found at $PYTHON_SCRIPT_PATH" 
    exit 1
fi

# Execute the Python script with the YAML configuration path as an argument
python3 "$PYTHON_SCRIPT_PATH" "$REPLACE_CONFIG_PATH" $4 $5

# Check the exit status of the Python script
if [ $? -eq 0 ]; then
    echo "XML values replacement completed successfully."
else
    echo "XML values replacement failed."
fi

