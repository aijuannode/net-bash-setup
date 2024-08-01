#!/bin/bash

# Check if OpenVPN is routing all traffic through the VPN
echo "Checking if OpenVPN is routing all traffic through the VPN..."
ip route show | grep -q "default via" && echo "OK" || echo "FAIL"

# Check if the OpenVPN server is configured to redirect all traffic
echo "Checking if the OpenVPN server is configured to redirect all traffic..."
grep -q "redirect-gateway def1" /etc/openvpn/server.conf && echo "OK" || echo "FAIL"

# Check if the OpenVPN client is configured to redirect all traffic
echo "Checking if the OpenVPN client is configured to redirect all traffic..."
grep -q "redirect-gateway def1" /etc/openvpn/client.conf && echo "OK" || echo "FAIL"

# Check the current IP address
echo "Current IP address:"
curl -s https://api.ipify.org

# Check the routing table
echo "Routing table:"
ip route show