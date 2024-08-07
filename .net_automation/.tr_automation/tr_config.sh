#!/bin/bash

# Check if Tor is already installed
if [ -x "/usr/bin/tor" ]; then
  echo "Tor is already installed, skipping installation..."
else
  # Update the package list
  sudo apt update

  # Install Tor
  sudo apt install -y tor
fi

# Configure Tor
sudo echo "SOCKSPort 9050" >> /etc/tor/torrc
sudo echo "ExitNodes {US}" >> /etc/tor/torrc

# Restart Tor service
sudo systemctl restart tor
sudo systemctl start tor