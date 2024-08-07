#!/bin/bash

# Remove OpenVPN package
sudo apt-get purge openvpn

# Remove OpenVPN configuration files
sudo rm -rf /etc/openvpn
sudo rm -rf /usr/share/openvpn
sudo rm -rf /var/lib/openvpn

# Remove OpenVPN logs
sudo rm -rf /var/log/openvpn

# Remove OpenVPN systemd service files (if applicable)
sudo rm -rf /lib/systemd/system/openvpn.service
sudo rm -rf /etc/systemd/system/openvpn.service

# Remove OpenVPN init script files (if applicable)
sudo rm -rf /etc/init.d/openvpn

# Remove OpenVPN user files (if applicable)
sudo rm -rf ~/.openvpn

# Update package list and remove any remaining dependencies
sudo apt-get autoremove
sudo apt-get autoclean

# Remove OpenVPN package configuration files
sudo dpkg --purge openvpn

echo "OpenVPN and related files removed."
