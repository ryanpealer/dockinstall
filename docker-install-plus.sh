#!/bin/sh

echo "Starting docker install..."
echo "Removing any old instances of docker and installing dependencies"
apt remove -y docker docker-engine docker.io containerd runc
apt update
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

echo "Dowloading latest docker and adding official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Pulling the latest repository"
echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

echo "Installing docker"
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Docker install completed, installing docker-compose"

echo "Dowloading docker-compose 1.25.5 - be sure to update to the latest stable"
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "Setting binary permissions"
chmod +x /usr/local/bin/docker-compose

echo “Docker and docker-compose install complete”

# Run docker as non-root user on Ubuntu
sudo usermod -aG docker $USER

echo "Add build tools"
sudo apt install make
sudo apt install build-essential

echo "setup portainer agent"
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.9.3
