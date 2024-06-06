#!/bin/bash

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

source $(dirname $0)/symphony_stage_script_provider.sh

# Commands to execute
current_time=$(date "+%Y.%m.%d-%H:%M:%S")
echo $current_time >> /tmp/stuff

# Write the updated key-value pairs to the output file
echo_output_dictionary_to_output_file