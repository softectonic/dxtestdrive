#!/bin/bash

# Path to JSON file
JSON_FILE="release-definitions/release-vars-file.json"

# Read variables from JSON file
RELEASE_NAME=$(jq -r '.releaseName' "$JSON_FILE")
RELEASE_BRANCH=$(jq -r '.releaseBranch' "$JSON_FILE")
RELEASE_DEFINITIONS_DIR=$(jq -r '.releaseDefinitionsDir' "$JSON_FILE")
SFDX_PROJECT_FILE=$(jq -r '.sfdxProjectFile' "$JSON_FILE")
SOURCE_TAG=$(jq -r '.sourceTag' "$JSON_FILE")

# Generate Release Definition
sfp releasedefinition:generate -n "$RELEASE_NAME" -b "$RELEASE_BRANCH" -d "$RELEASE_DEFINITIONS_DIR" -f "$SFDX_PROJECT_FILE" -c "$SOURCE_TAG" --forcepush

