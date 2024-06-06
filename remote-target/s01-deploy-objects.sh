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

# Register target (in remote agent)
curl -X POST -d @target.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/targets/registry/remote-cmd

# Create solution
curl -X POST -d @solution.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/solutions/target-runtime-remote-cmd-solution

# Create Instance (solution -> target)
curl -X POST -d @instance.json -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/instances/target-runtime-remote-cmd-instance
