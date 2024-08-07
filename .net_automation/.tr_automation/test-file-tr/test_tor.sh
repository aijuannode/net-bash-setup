#!/bin/bash

# Check IP address before connecting to Tor
echo "Your IP address before connecting to Tor:"
curl -s -L https://ipify.org

# Check IP address after connecting to Tor
echo "Your IP address after connecting to Tor:"
torsocks curl -s -L https://ipify.org