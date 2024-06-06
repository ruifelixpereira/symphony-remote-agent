#!/bin/bash

# Copyright (C) Microsoft Corporation.

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

# This script is used to test the Symphony API
# It creates a target, a solution, an instance catalog and a campaign
SYMPHONY_BASE_URL="http://localhost:8082/v1alpha2"

# Get token
token=$(curl -X POST -d '{"username":"admin", "password":""}' $SYMPHONY_BASE_URL/users/auth | jq -r '.accessToken')

# Register target (in remote agent)
curl -X POST -d @target.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/targets/registry/remote-cmd

# Create Solution
curl -X POST -d @solution.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/solutions/target-runtime-remote-campaign-cmd-solution

# Create Instance Catalog
curl -X POST -d @instance-catalog.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/catalogs/registry/target-runtime-remote-campaign-cmd-instance

# Create Campaign
curl -X POST -d @campaign.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/campaigns/run-cmd-campaign
