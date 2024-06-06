#!/bin/bash

# Copyright (C) Microsoft Corporation.

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

# This script is used to test the Symphony API
# It get all the created instances

SYMPHONY_BASE_URL="http://localhost:8082/v1alpha2"

# Get token
token=$(curl -X POST -d '{"username":"admin", "password":""}' $SYMPHONY_BASE_URL/users/auth | jq -r '.accessToken')

# Validate the created Instance
curl -X GET -H "Authorization: Bearer $token" $SYMPHONY_BASE_URL/instances
