#!/bin/bash

# Update package index and install OpenVPN
sudo apt update -y
sudo apt install openvpn -y

# Install Easy-RSA
sudo apt install easy-rsa -y

# Change into the Easy-RSA directory
cd /usr/share/easy-rsa

# Initialize the Certificate Authority (CA)
sudo ./easyrsa init-pki

# Generate the CA certificate
echo "CA" | sudo ./easyrsa build-ca nopass

# Generate the server certificate
echo "server" | sudo ./easyrsa gen-req server nopass
echo "yes" | sudo ./easyrsa sign-req server server

# Generate the Diffie-Hellman parameters
sudo ./easyrsa gen-dh

# Change into the pki directory
cd pki

# Move the generated files to the OpenVPN directory
sudo mkdir -p /etc/openvpn/server

if [ -f "ca.crt" ]; then
    sudo mv ca.crt /etc/openvpn/server/
fi

if [ -f "private/ca.key" ]; then
    sudo mv private/ca.key /etc/openvpn/server/
fi

if [ -f "issued/server.crt" ]; then
    sudo mv issued/server.crt /etc/openvpn/server/
else
    echo "Error: issued/server.crt not found"
fi

if [ -f "private/server.key" ]; then
    sudo mv private/server.key /etc/openvpn/server/
fi

if [ -f "dh.pem" ]; then
    sudo mv dh.pem /etc/openvpn/server/dh2048.pem
else
    echo "Error: dh.pem not found"
fi

# Change back to the original directory
cd ~

# Check if port 1194 is already in use
if sudo lsof -i :1194 > /dev/null; then
  echo "Port 1194 is already in use. Stopping the process..."
  sudo lsof -i :1194 | awk '{print $2}' | xargs sudo kill
fi

# Configure the OpenVPN server
sudo tee /etc/openvpn/server.conf <<EOF
port 1194
proto udp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/server.crt
key /etc/openvpn/server/server.key
dh /etc/openvpn/server/dh2048.pem
topology subnet
server 10.8.0.0 255.255.255.0
data-ciphers-fallback BF-CBC
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
EOF

# Start the OpenVPN server
sudo openvpn --config /etc/openvpn/server.conf