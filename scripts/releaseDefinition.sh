#!/bin/bash

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

# Path to JSON file
JSON_FILE="release-definitions/release-vars-file.json"

# Read variables from JSON file
RELEASE_NAME=$(jq -r '.releaseName' "$JSON_FILE")
RELEASE_BRANCH=$(jq -r '.releaseBranch' "$JSON_FILE")
RELEASE_DEFINITIONS_DIR=$(jq -r '.releaseDefinitionsDir' "$JSON_FILE")
SFDX_PROJECT_FILE=$(jq -r '.sfdxProjectFile' "$JSON_FILE")
SOURCE_TAG=$(jq -r '.sourceTag' "$JSON_FILE")

# Generate Release Definition
sfp releasedefinition:generate -n "$RELEASE_NAME" -b "$RELEASE_BRANCH" -d "$RELEASE_DEFINITIONS_DIR" -f "$SFDX_PROJECT_FILE" -c "$SOURCE_TAG"

