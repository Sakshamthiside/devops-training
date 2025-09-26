#!/bin/bash

# Create a user
echo "Enter your username!"
read username
echo "You entered: $username"
sudo adduser "$username"

# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "Docker found! Updating Docker..."
    sudo apt-get update
    sudo apt-get install --only-upgrade -y docker-ce docker-ce-cli containerd.io
    echo "Docker updated!"
else
    echo "Docker not installed! Installing Docker..."

    sudo apt-get update

    sudo apt-get install -y ca-certificates curl gnupg lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    echo "Docker installed successfully!"
fi

# Add user to the Docker group (this is useful whether Docker was installed or updated)
sudo usermod -aG docker "$username"
echo "Added $username to docker group. You may need to log out and back in."

# Check if docker-compose V1 is installed
if command -v docker-compose &> /dev/null; then
    echo "Docker-Compose V1 found! Updating Docker-Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker-Compose V1 updated to latest version."
elif docker compose version &> /dev/null; then
    echo "Docker Compose V2 Plugin found! Updating..."
    sudo apt-get update
    sudo apt-get install --only-upgrade -y docker-compose-plugin
    echo "Docker Compose V2 Plugin updated."
else
    echo "Docker-Compose not found! Installing Docker-Compose..."

    # Install Docker Compose V1 standalone binary
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker-Compose V1 installed."

    # Also install Docker Compose V2 plugin (optional)
    echo "Installing Docker Compose V2 Plugin..."
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
    echo "Docker Compose V2 Plugin installed."
fi
