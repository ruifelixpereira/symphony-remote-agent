#!/bin/bash

# Copyright (C) Microsoft Corporation.

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

# This script is used to test the Symphony API
# It activates the campaign

SYMPHONY_BASE_URL="http://localhost:8082/v1alpha2"

# Get token
token=$(curl -X POST -d '{"username":"admin", "password":""}' $SYMPHONY_BASE_URL/users/auth | jq -r '.accessToken')

# Activate Campaign
curl -X POST -d @activation.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/activations/registry/run-cmd-campaign-activation
