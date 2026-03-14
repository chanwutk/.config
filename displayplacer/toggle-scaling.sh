#!/bin/bash

# Get current display configuration (only the last line contains the command)
current_config=$(displayplacer list | tail -n 1)

# Check if scaling is currently on or off and toggle it
if echo "$current_config" | grep -q "scaling:on"; then
    # Scaling is on, turn it off
    echo "Current scaling: ON → Switching to OFF"
    new_config=$(echo "$current_config" | sed 's/scaling:on/scaling:off/g')
else
    # Scaling is off, turn it on
    echo "Current scaling: OFF → Switching to ON"
    new_config=$(echo "$current_config" | sed 's/scaling:off/scaling:on/g')
fi

# Remove hz parameter from the configuration
new_config=$(echo "$new_config" | sed 's/ hz:[^ ]*//g')

# Apply the new configuration
eval "$new_config"
