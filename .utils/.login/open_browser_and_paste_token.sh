#!/bin/bash

# Get the token as an argument
TOKEN=$1

# Open the browser using xdg-open
xdg-open "https://github.com/login/device" &

# Wait for the browser to open
sleep 2

# Paste the token into the browser
xdotool type --delay 100 "$TOKEN"
xdotool key Return