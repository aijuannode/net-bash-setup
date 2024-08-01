#!/bin/bash

# Set your OpenVPN server IP and port
SERVER_IP="your_server_ip"
SERVER_PORT="1194"

# Set your OpenVPN client configuration file
CLIENT_CONFIG="/path/to/client.ovpn"

# Test 1: Check if OpenVPN client can connect to the server
echo "Testing OpenVPN connection..."
openvpn --config $CLIENT_CONFIG --connect $SERVER_IP:$SERVER_PORT
if [ $? -eq 0 ]; then
  echo "Connection established successfully."
else
  echo "Failed to establish connection."
  exit 1
fi

# Test 2: Check if traffic is being redirected through the VPN tunnel
echo "Testing traffic redirect..."
ip route show | grep "default via $SERVER_IP"
if [ $? -eq 0 ]; then
  echo "Traffic is being redirected through the VPN tunnel."
else
  echo "Traffic is not being redirected through the VPN tunnel."
  exit 1
fi

# Test 3: Check if DNS is being resolved through the VPN tunnel
echo "Testing DNS resolution..."
dig +short google.com | grep "your_vpn_dns_server_ip"
if [ $? -eq 0 ]; then
  echo "DNS is being resolved through the VPN tunnel."
else
  echo "DNS is not being resolved through the VPN tunnel."
  exit 1
fi

# Test 4: Check if traffic is being blocked when VPN connection is dropped
echo "Testing traffic blockage when VPN connection is dropped..."
openvpn --config $CLIENT_CONFIG --connect $SERVER_IP:$SERVER_PORT
sleep 5
pkill openvpn
sleep 5
curl -s -f -m 5 http://google.com > /dev/null
if [ $? -eq 0 ]; then
  echo "Traffic is not being blocked when VPN connection is dropped."
  exit 1
else
  echo "Traffic is being blocked when VPN connection is dropped."
fi

echo "All tests passed."