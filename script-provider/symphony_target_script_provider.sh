#!/bin/bash

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

# component result, the status code should be one of
# 8001: failed to update
# 8002: failed to delete
# 8003: failed to validate component artifact
# 8004: updated (success)
# 8005: deleted (success)
# 9998: untouched - no actions are taken/necessary
SYMPHONY_COMPONENT_FAILED_UPDATE=8001
SYMPHONY_COMPONENT_FAILED_DELETE=8002
SYMPHONY_COMPONENT_FAILED_VALIDATE=8003
SYMPHONY_COMPONENT_SUCCESS_UPDATE=8004
SYMPHONY_COMPONENT_SUCCESS_DELETE=8005
SYMPHONY_COMPONENT_UNTOUCHED=9998

# Executes a command and echoes command's output.
# Arguments:
#   command: The command to execute.
#   base_command_output: A reference to a variable that will hold the command output.
#   base_command_status: A reference to a variable that will hold the command status code.
function execute_command_with_status_code() {
    local key=$1
    local command=$2
    local -n base_command_output=$3
    local -n base_command_status=$4

    # Execute the command and capture output
    base_command_output=$(eval "$command" 2>&1) || base_command_status=$?
    if [ $base_command_status -ne 0 ]; then
        echo_error_to_output_dictionary "$key" "$base_command_output"
    else
        echo_success_to_output_dictionary "$key" "$base_command_output"
    fi
}

# Inserts a success status to the output dictionary
# Arguments:
#   key: The key
#   message: The success message.
function echo_success_to_output_dictionary() {
    local key=$1
    local message="$2"
    echo_key_status_to_output_dictionary "$key" $SYMPHONY_COMPONENT_SUCCESS_UPDATE "$message"
}

# Inserts an error status and message to the output dictionary
# Arguments:
#   key: The key
#   error: The error message.
function echo_error_to_output_dictionary() {
    local key=$1
    local error="$2"
    echo_key_status_to_output_dictionary "$key" $SYMPHONY_COMPONENT_FAILED_UPDATE "$error"
}

# Outputs our dictionary to a file.
function echo_output_dictionary_to_output_file() {
    echo "$outputs" | tee "$output_file"
}

# Inserts a key-status pair to the output dictionary
# Arguments:
#   key: The key
#   status: The status code
#   message: The success or error message
function echo_key_status_to_output_dictionary() {
    local key=$1
    local status=$2
    local message="$3"
    outputs=$(echo "$outputs" | jq --arg key "$key" --arg status "$status" --arg message "$message" '.[$key] = { status: $status|tonumber, message: $message }' )
}

# Gets a value from the output dictionary by passing a key
# Arguments:
#   key: The key
function get_value_from_output_dictionary() {
    local key=$1
    echo "$outputs" | jq -r --arg key "$key" '.[$key]'
}

# Arguments
inputs_file=$1

# Initialize outputs dictionary.
outputs="{}"

# Generate the output file name
output_file="${inputs_file%.*}-output.${inputs_file##*.}"
