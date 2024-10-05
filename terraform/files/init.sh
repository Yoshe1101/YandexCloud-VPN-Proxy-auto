#!/bin/bash

# Update package lists
sudo apt-get update

# Install prerequisites for Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again to include Docker’s packages
sudo apt-get update

# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Verify Docker installation
docker --version

# Install Docker Compose (latest stable release)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Set the correct permissions for Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
docker-compose --version

# Add the current user to the Docker group (optional, to avoid using sudo for docker commands)
sudo usermod -aG docker $USER

echo "Docker and Docker Compose have been installed successfully. You may need to log out and back in for Docker group changes to take effect."
echo "Starting services."
echo "Starting services.."
echo "Starting services..."

sudo docker-compose up -d