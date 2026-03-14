#!/bin/bash

# Get current display configuration (only the last line contains the command)
current_config=$(displayplacer list | tail -n 1)

# Remove hz parameter from the configuration
new_config=$(echo "$current_config" | sed 's/ hz:[^ ]*//g')

# Apply the new configuration
eval "$new_config"
