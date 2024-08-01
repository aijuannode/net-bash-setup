#!/bin/bash

# Check the OpenVPN connection
echo "Checking OpenVPN connection..."
if pgrep -f openvpn > /dev/null; then
  echo "OpenVPN connection is active"
else
  echo "OpenVPN connection is not active"
  exit 1
fi

# Check the routing table
echo "Checking routing table..."
ip route show | grep -q "default via" && echo "Default route is set" || echo "Default route is not set"

# Check the current IP address
echo "Current IP address:"
curl -s https://api.ipify.org

# Check the routing table again
echo "Routing table:"
ip route show