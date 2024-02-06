#!/usr/bin/env sh

# Use environment variables for Email Address and DisplayName passed from GitHub Secrets
ADDRESS=${SF_EMAIL_ADDRESS}
DISPLAY_NAME=${SF_DISPLAY_NAME}

# Salesforce CLI command to create an OrgWideEmailAddress record with configurable values
sf data create record --sobject OrgWideEmailAddress --values "Address=${ADDRESS} DisplayName='${DISPLAY_NAME}' IsAllowAllProfiles=true"
