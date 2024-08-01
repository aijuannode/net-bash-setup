# Change into the Easy-RSA directory
cd /usr/share/easy-rsa

# Initialize the Certificate Authority (CA)
sudo ./easyrsa init-pki

# Generate the CA certificate
sudo ./easyrsa build-ca

# Generate the server certificate
sudo ./easyrsa gen-req server
sudo ./easyrsa sign-req server server

# Generate the Diffie-Hellman parameters
sudo ./easyrsa gen-dh
