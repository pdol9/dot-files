#!/bin/bash

# Get the Alacritty window ID
WINDOW_ID=$(xdotool search --onlyvisible --class alacritty | head -n 1)

# narrow and wide dimensions (in pixels)
NARROW_WIDTH=1600
NARROW_HEIGHT=900
WIDE_WIDTH=2900
WIDE_HEIGHT=1400

# Get the window width
CURRENT_WIDTH=$(xdotool getwindowgeometry $(xdotool search --onlyvisible --class alacritty | head -n 1) | grep -oP "Geometry: \K\d+")

if [ "$CURRENT_WIDTH" -eq "$WIDE_WIDTH" ]; then
    xdotool windowsize "$WINDOW_ID" "$NARROW_WIDTH" "$NARROW_HEIGHT"
else
    xdotool windowsize "$WINDOW_ID" "$WIDE_WIDTH" "$WIDE_HEIGHT"
fi
