#!/bin/bash

# Update package index and install OpenVPN
sudo apt update
sudo apt install openvpn

# Install Easy-RSA
sudo apt install easy-rsa

# Initialize the Certificate Authority (CA)
sudo easyrsa init-pki

# Generate the CA certificate
sudo easyrsa build-ca

# Generate the server certificate
sudo easyrsa gen-req server nopass
sudo easyrsa sign-req server server

# Generate the Diffie-Hellman parameters
sudo easyrsa gen-dh

# Generate the HMAC signature
sudo openvpn --genkey --secret /etc/openvpn/server/ta.key

# Configure the OpenVPN server
sudo tee /etc/openvpn/server/server.conf <<EOF
port 1194
proto udp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/server.crt
key /etc/openvpn/server/server.key
dh /etc/openvpn/server/dh2048.pem
topology subnet
server 10.8.0.0 255.255.255.0
EOF

# Start the OpenVPN server
sudo systemctl start openvpn-server

# Enable the OpenVPN server to start at boot
sudo systemctl enable openvpn-server
