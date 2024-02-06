#!/usr/bin/env sh

# Use environment variables for Email Address and DisplayName passed from GitHub Secrets
ADDRESS="${SF_EMAIL_ADDRESS}"
DISPLAY_NAME="${SF_DISPLAY_NAME}"

# Attempt to get the existing OrgWideEmailAddress record
RESULT=$(sf data record get --sobject OrgWideEmailAddress --where "Address='${ADDRESS}'" --json 2>&1)

# Check command exit code or result for "No matching record found."
if echo "${RESULT}" | grep -q "No matching record found." || echo "${RESULT}" | grep -q "\"code\": 1"; then
    echo "Email address does not exist. Creating new OrgWideEmailAddress record."
    # Salesforce CLI command to create an OrgWideEmailAddress record with configurable values
    sf data create record --sobject OrgWideEmailAddress --values "Address=${ADDRESS} DisplayName='${DISPLAY_NAME}' IsAllowAllProfiles=true Purpose=DefaultNoreply"
else
    echo "Email address already exists. No action taken."
fi
