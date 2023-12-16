!/bin/bash

# Script: release-definition.sh
# 
# Description:
# This script is responsible for generating the release definition file for the Salesforce deployment.
# It uses parameters specified in 'release-vars-file.json' to create a tailored release definition,
# which is used later in the deployment process. The script ensures that each release is 
# accurately defined and recorded, facilitating a controlled and repeatable deployment process.
#
# Usage:
# ./releaseDefinition.sh
# 
# The script reads required parameters from 'release-vars-file.json', such as the release name,
# and then generates the release definition file accordingly. The generated file is saved in the
# 'release-definitions' directory of the project.
#
# Note: This script should be executed in the context of a GitHub Actions workflow or
# in an environment where all necessary dependencies and environment variables are set.
#


# Default values
default_config_file="${default_directory}/config.yml"

# GitHub environment variables
##github_ref=${GITHUB_REF:-}
#github_sha=${GITHUB_SHA:-}

# Extract branch name from GITHUB_REF
#branch_name=""
#if [[ "$github_ref" == refs/heads/* ]]; then
#  branch_name=${github_ref#refs/heads/}
#fi

# Use provided values or defaults
CONFIG_FILE=${1:-$default_config_file}
RELEASE_NAME="release"
DIRECTORY="release-definitions"
BRANCH="release-definition"
SOURCE_TAG="main"


# Check if releaseName is the placeholder and replace it with today's date
#if [ "$RELEASE_NAME" == "release-placeholder" ]; then
#    RELEASE_NAME="release-$today"
#fi

echo "Release Name: $RELEASE_NAME"
echo "Branch: $BRANCH"
echo "Directory: $DIRECTORY"
echo "Config File: $CONFIG_FILE"
echo "Source Tag: $SOURCE_TAG"

# Checkout to the new branch
git checkout release-definition

# Generate Release Definition
sfp releasedefinition:generate -n "$RELEASE_NAME" -b "$BRANCH" -d "$DIRECTORY" -f "$CONFIG_FILE" -c "$SOURCE_TAG"

