#!/bin/bash

# Exit immediately if a command fails
set -e

# Fail if an unset variable is used
set -u

source $(dirname $0)/symphony_target_script_provider.sh

deployment=$1 # first parameter file is the deployment object
references=$2 # second parmeter file contains the reference components

# the apply script is called with a list of components to be updated via
# the references parameter
components=$(jq -c '.[]' "$references")

echo "COMPONENTS: $components"

while IFS= read -r line; do
    # Extract the name and age fields from each JSON object
    name=$(echo "$line" | jq -r '.name')
    properties=$(echo "$line" | jq -r '.properties')
    command_to_execute=$(echo "$line" | jq -r '.properties.command')
    #echo "NAME: $name"
    #echo "PROPERTIES: $properties"
    #echo "COMMAND: $command_to_execute"

    command_output=""
    command_status=0
    execute_command_with_status_code $name "$command_to_execute" command_output command_status

done <<< "$components"

# Write the updated key-value pairs to the output file
echo_output_dictionary_to_output_file

#output_results='{
#    "remote-cmd1": {
#        "status": 8004,
#        "message": ""
#    },
#    "remote-cmd2": {
#        "status": 8004,
#        "message": ""
#    }
#}'

#echo "$output_results" > ${deployment%.*}-output.${deployment##*.}