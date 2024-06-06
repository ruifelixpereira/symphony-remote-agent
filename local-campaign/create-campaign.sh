#!/bin/bash

# Copyright (C) Microsoft Corporation.

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

# This script is used to test the Symphony API
# Usage: execute line by line from the symphony_campaign outuput directory

SYMPHONY_BASE_URL="http://localhost:8082/v1alpha2"

# Get token
token=$(curl -X POST -d '{"username":"admin", "password":""}' $SYMPHONY_BASE_URL/users/auth | jq -r '.accessToken')

# Create Campaign
#curl -X POST -d @{{parameters.campaign_name}}.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/campaigns/{{parameters.campaign_name|e}}
curl -X POST -d @campaign.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/campaigns/stuff-campaign

#curl -X POST -d @symphony_campaign_activation.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/activations/registry/{{parameters.campaign_activation_name|e}}
curl -X POST -d @activation.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/activations/registry/stuff-activation
