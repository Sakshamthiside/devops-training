# devops bootcamp

This repository contains scripts and work for my DevOps internship assignments.

## Prerequisites / Requirements
- Ubuntu 22.04 LTS (tested)
- A user with sudo privileges
- Internet / ability to run 'apt update'
- Git

## Script: setup_docker_user.sh

What this script does:
1. Creates a new user if it doesn't exist
2. Sets up SSH key authentication for that user
3. Installs Docker
4. Prints system info (CPU, memory, disk, IP)
5. Installs Docker-Compose and V2 Plugin

### Usage

```bash
# (clone this repo)
git clone
https://github.com/Sakshamthiside/devops-bootcamp.git
cd devops-bootcamp

# make script executable (if not already)
chmod +x setup_docker_user.sh

# run the script (with sudo if needed)
sudo ./setup_docker_user.sh

### Usage

```bash
## Build and start containers
docker compose up -d --build

### Check running containers
docker compose ps

### Test the app
curl http://localhost:3000

### Expected Output (first run)
Hello from Node.js! This page has been visited 1 times.

### Second run:
Hello from Node.js! This page has been visited 2 times.
