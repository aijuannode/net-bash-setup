#!/bin/bash

# Check if OpenVPN is running
if pgrep openvpn > /dev/null
then
    echo "OpenVPN is running"
else
    echo "OpenVPN is not running"
    exit 1
fi

# Check if the OpenVPN tunnel is established
if ip addr show tun0 > /dev/null
then
    echo "OpenVPN tunnel is established"
else
    echo "OpenVPN tunnel is not established"
    exit 1
fi

# Get the old IP address
OLD_IP=$(curl -s 4.icanhazip.com)
if [ -z "$OLD_IP" ]
then
    echo "Failed to get old IP address"
    exit 1
fi
echo "Old IP address: $OLD_IP"

# Connect to the OpenVPN server
sudo openvpn --config /etc/openvpn/server.conf &

# Wait for the connection to establish
sleep 10

# Get the new IP address
NEW_IP=$(curl -s 4.icanhazip.com)
if [ -z "$NEW_IP" ]
then
    echo "Failed to get new IP address"
    exit 1
fi
echo "New IP address: $NEW_IP"

if [ "$OLD_IP" != "$NEW_IP" ]
then
    echo "IP address has changed successfully"
else
    echo "IP address has not changed"
    exit 1
fi

# Check if internet access is working
if ping -c 1 google.com > /dev/null
then
    echo "Internet access is working"
else
    echo "Internet access is not working"
    exit 1
fi

# Check if DNS resolution is working
if dig +short google.com > /dev/null
then
    echo "DNS resolution is working"
else
    echo "DNS resolution is not working"
    exit 1
fi

echo "OpenVPN setup is working correctly"
