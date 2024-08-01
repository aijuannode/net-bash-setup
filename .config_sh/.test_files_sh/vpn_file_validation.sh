#!/bin/bash

# Check if OpenVPN is routing all traffic through the VPN
echo "Checking if OpenVPN is routing all traffic through the VPN..."
ip route show | grep -q "default via" && echo "OK" || echo "FAIL"

# Check if the OpenVPN server is configured to NAT traffic
echo "Checking if the OpenVPN server is configured to NAT traffic..."
ip addr show | grep -q "inet " && echo "OK" || echo "FAIL"

# Check if the OpenVPN client is configured to use the VPN DNS
echo "Checking if the OpenVPN client is configured to use the VPN DNS..."
resolvectl status | grep -q "Current DNS Server" && echo "OK" || echo "FAIL"

# Check if the OpenVPN server is configured to assign a new IP address
echo "Checking if the OpenVPN server is configured to assign a new IP address..."
ip addr show | grep -q "inet " && echo "OK" || echo "FAIL"

# Check the current IP address
echo "Current IP address:"
curl -s https://api.ipify.org

# Check the DNS servers
echo "DNS servers:"
resolvectl status | grep "Current DNS Server"

# Check the routing table
echo "Routing table:"
ip route show