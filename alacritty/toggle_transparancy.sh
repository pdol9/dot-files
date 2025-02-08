#!/bin/bash

# Path to alacritty configuration file
CONFIG_FILE="$HOME/.config/alacritty/alacritty.yml"

# Define transparency values
TRANSPARENT="0.6"
OPAQUE="0.90"

# Check current transparency
CURRENT_OPACITY=$(grep "opacity" "$CONFIG_FILE" | awk '{print $2}')

if [ "$CURRENT_OPACITY" == "$TRANSPARENT" ]; then
    # Set to opaque
    sed -i "s/opacity: $TRANSPARENT/opacity: $OPAQUE/g" "$CONFIG_FILE"
else
    # Set to transparent
    sed -i "s/opacity: $OPAQUE/opacity: $TRANSPARENT/g" "$CONFIG_FILE"
fi
