#!/bin/bash

# Create the client configuration file if it doesn't exist
if [ ! -f /etc/openvpn/client.conf ]; then
  echo "Creating client configuration file..."
  sudo touch /etc/openvpn/client.conf
  sudo echo "redirect-gateway def1" >> /etc/openvpn/client.conf
fi

# Add the redirect-gateway directive to the server configuration file
if [ ! -f /etc/openvpn/server.conf ]; then
  echo "Creating server configuration file..."
  sudo touch /etc/openvpn/server.conf
fi

if ! grep -q "push \"redirect-gateway def1\"" /etc/openvpn/server.conf; then
  echo "Adding redirect-gateway directive to server configuration file..."
  sudo echo "push \"redirect-gateway def1\"" >> /etc/openvpn/server.conf
fi

# Check if OpenVPN is routing all traffic through the VPN
echo "Checking if OpenVPN is routing all traffic through the VPN..."
ip route show | grep -q "default via" && echo "OK" || echo "FAIL"

# Check if the OpenVPN server is configured to redirect all traffic
echo "Checking if the OpenVPN server is configured to redirect all traffic..."
grep -q "push \"redirect-gateway def1\"" /etc/openvpn/server.conf && echo "OK" || echo "FAIL"

# Check if the OpenVPN client is configured to redirect all traffic
echo "Checking if the OpenVPN client is configured to redirect all traffic..."
grep -q "redirect-gateway def1" /etc/openvpn/client.conf && echo "OK" || echo "FAIL"

# Check the current IP address
echo "Current IP address:"
curl -s https://api.ipify.org

# Check the routing table
echo "Routing table:"
ip route show