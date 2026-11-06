 
# Docker: Complete Practical Training Guide

A beginner-to-advanced guide to learning Docker, managing containers, building custom images, configuring networking and storage, monitoring resources, performing security checks, and maintaining Docker projects.

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Docker Architecture](#2-docker-architecture)
3. [Prerequisites](#3-prerequisites)
4. [Install Docker](#4-install-docker)
5. [Docker Basic Concepts](#5-docker-basic-concepts)
6. [Docker Command Basics](#6-docker-command-basics)
7. [Image Management](#7-image-management)
8. [Container Management](#8-container-management)
9. [Docker Run Options](#9-docker-run-options)
10. [Build Custom Images](#10-build-custom-images)
11. [Dockerfile Instructions](#11-dockerfile-instructions)
12. [Build a Custom Kali Image](#12-build-a-custom-kali-image)
13. [Users and Permissions](#13-users-and-permissions)
14. [Docker Networking](#14-docker-networking)
15. [Port Mapping](#15-port-mapping)
16. [Docker Volumes](#16-docker-volumes)
17. [Bind Mounts](#17-bind-mounts)
18. [Resource Management](#18-resource-management)
19. [Resource Monitoring](#19-resource-monitoring)
20. [Docker Security Checks](#20-docker-security-checks)
21. [Docker Security Best Practices](#21-docker-security-best-practices)
22. [Logs and Troubleshooting](#22-logs-and-troubleshooting)
23. [Docker Compose](#23-docker-compose)
24. [Docker Cleanup](#24-docker-cleanup)
25. [Useful Docker Aliases](#25-useful-docker-aliases)
26. [Docker Project Structure](#26-docker-project-structure)
27. [Docker Ignore Files](#27-docker-ignore-files)
28. [Git and GitHub](#28-git-and-github)
29. [Common Errors](#29-common-errors)
30. [Quick Command Reference](#30-quick-command-reference)
31. [Practical Workflow](#31-practical-workflow)
32. [Learning Roadmap](#32-learning-roadmap)

---

# 1. Introduction

Docker is a platform used to build, package, and run applications in isolated environments called containers.

### Why Docker?

- Run applications without installing every dependency on the host.
- Create consistent development environments.
- Build reusable custom images.
- Start and stop environments quickly.
- Isolate applications and their dependencies.
- Simplify development, testing, and deployment.

### Where Docker is used

- Application development
- Software testing
- DevOps
- CI/CD pipelines
- Cloud deployments
- Microservices
- Security testing in authorized labs

# 2. Docker Architecture

Docker uses a client-server architecture.

| Component | Description |
|---|---|
| Docker Client | Accepts commands from the user |
| Docker Daemon | Manages Docker resources |
| Docker Image | Template used to create containers |
| Docker Container | Instance created from an image |
| Docker Registry | Stores and distributes images |
| Docker Volume | Provides persistent storage |
| Docker Network | Allows containers to communicate |

### Architecture flow

```text
User
  |
  v
Docker Client
  |
  v
Docker Daemon
  |
  +---- Images
  |
  +---- Containers
  |
  +---- Networks
  |
  +---- Volumes
  |
  v
Docker Registry
```

# 3. Prerequisites

Recommended environment:

- Ubuntu or Debian Linux
- WSL2 with a supported Linux distribution
- Kali Linux for an isolated learning environment
- Docker Engine
- Git
- Basic Linux command knowledge

Check the Linux version:

```bash
cat /etc/os-release
```

Check available memory:

```bash
free -h
```

Check disk space:

```bash
df -h
```

# 4. Install Docker

### Step 1: Update packages

```bash
sudo apt update
sudo apt upgrade -y
```

**Why:** Updates package information and installed software.

### Step 2: Install Docker

For a basic Ubuntu/Debian installation:

```bash
sudo apt install docker.io -y
```

**Why:** Installs Docker Engine from the distribution's package repository.

For production environments, follow the official Docker installation instructions for your distribution.

### Step 3: Start Docker

```bash
sudo systemctl enable --now docker
```

**Why:**
- `enable` configures Docker to start after reboot.
- `--now` starts Docker immediately.

### Step 4: Check Docker status

```bash
sudo systemctl status docker
```

### Step 5: Check Docker version

```bash
docker --version
docker info
```

### Step 6: Test Docker

```bash
sudo docker run hello-world
```

Expected result:

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

# 5. Docker Basic Concepts

| Concept | Meaning |
|---|---|
| Image | Read-only template |
| Container | Image instance |
| Dockerfile | Image build instructions |
| Volume | Persistent storage |
| Network | Container communication |
| Registry | Image storage |
| Compose | Multi-container management |

### Image vs Container

An image is a template. A container is created from that template.

One image can create multiple containers.

# 6. Docker Command Basics

General syntax:

```bash
docker [COMMAND] [OPTIONS] [ARGUMENTS]
```

Help commands:

```bash
docker --help
docker run --help
docker exec --help
docker image --help
docker container --help
```

# 7. Image Management

### Download an image

```bash
docker pull ubuntu
```

**Why:** Downloads the Ubuntu image from a registry.

### List images

```bash
docker images
```

### Inspect an image

```bash
docker image inspect ubuntu
```

**Why:** Displays image configuration and metadata.

### View image history

```bash
docker history ubuntu
```

### Remove an image

```bash
docker rmi ubuntu
```

**Why:** Removes an image that is no longer needed and is not being used by a container.

### Remove dangling images

```bash
docker image prune
```

Review the confirmation prompt before proceeding.

# 8. Container Management

### Run a container

```bash
docker run ubuntu
```

### Run an interactive container

```bash
docker run -it ubuntu bash
```

Explanation:

- `-i`: Keeps standard input open.
- `-t`: Allocates a terminal.
- `bash`: Starts the Bash shell.

### Run in background

```bash
docker run -dit --name ubuntu-lab ubuntu bash
```

Explanation:

- `-d`: Detached mode.
- `-i`: Interactive input.
- `-t`: Terminal allocation.
- `--name`: Assigns a container name.

### List running containers

```bash
docker ps
```

### List all containers

```bash
docker ps -a
```

### Enter an existing container

```bash
docker exec -it ubuntu-lab bash
```

**Important difference:**

| Command | Purpose |
|---|---|
| `docker run` | Creates and starts a new container |
| `docker exec` | Runs a command inside an existing running container |

### Stop a container

```bash
docker stop ubuntu-lab
```

### Start a stopped container

```bash
docker start ubuntu-lab
```

### Restart a container

```bash
docker restart ubuntu-lab
```

### Remove a container

```bash
docker rm ubuntu-lab
```

### Force remove a container

```bash
docker rm -f ubuntu-lab
```

Use force removal carefully because it stops a running container.

# 9. Docker Run Options

| Option | Purpose |
|---|---|
| `-i` | Interactive input |
| `-t` | Allocate terminal |
| `-d` | Background execution |
| `-it` | Interactive terminal |
| `-dit` | Detached interactive terminal |
| `--name` | Container name |
| `--hostname` | Container hostname |
| `-p` | Publish a port |
| `-v` | Mount storage |
| `--rm` | Remove container after it exits |
| `--memory` | Set memory limit |
| `--cpus` | Set CPU limit |
| `--network` | Select a network |
| `--read-only` | Make the root filesystem read-only |

Example:

```bash
docker run --rm hello-world
```

**Why:** Useful for short-lived tests that do not need a retained container.

# 10. Build Custom Images

A Dockerfile contains instructions used to create a Docker image.

### Step 1: Create a directory

```bash
mkdir -p ~/project/docker-lab
cd ~/project/docker-lab
```

### Step 2: Create a Dockerfile

```bash
nano Dockerfile
```

Add:

```dockerfile
# Use Ubuntu as the base image
FROM ubuntu:24.04

# Add image metadata
LABEL maintainer="Docker Training Lab"

# Install basic tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    git \
    nano && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Set the default command
CMD ["/bin/bash"]
```

### Step 3: Build the image

```bash
docker build -t my-ubuntu-lab:1.0 .
```

Explanation:

- `build`: Builds an image.
- `-t`: Assigns a name and tag.
- `.`: Uses the current directory as the build context.

### Step 4: Verify the image

```bash
docker images
docker image inspect my-ubuntu-lab:1.0
```

### Step 5: Run the custom image

```bash
docker run -dit --name my-lab my-ubuntu-lab:1.0
```

### Step 6: Enter the container

```bash
docker exec -it my-lab bash
```

# 11. Dockerfile Instructions

| Instruction | Purpose |
|---|---|
| `FROM` | Selects the base image |
| `RUN` | Executes commands during image build |
| `CMD` | Defines the default command |
| `ENTRYPOINT` | Defines the main executable |
| `COPY` | Copies files into the image |
| `ADD` | Copies files with additional features |
| `WORKDIR` | Sets the working directory |
| `ENV` | Defines environment variables |
| `ARG` | Defines build-time variables |
| `EXPOSE` | Documents intended container ports |
| `USER` | Sets the default runtime user |
| `LABEL` | Adds image metadata |

**Important:** `EXPOSE` does not publish a port. Use `-p` when running the container to publish a port.

# 12. Build a Custom Kali Image

Create a separate directory:

```bash
mkdir -p ~/project/Docker-Training/examples/kali
cd ~/project/Docker-Training/examples/kali
```

Create a Dockerfile:

```bash
nano Dockerfile
```

Add:

```dockerfile
# Use Kali rolling as the base image
FROM kalilinux/kali-rolling

# Avoid interactive package installation prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools and sudo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    bash \
    nano \
    vim \
    curl \
    wget \
    git && \
    rm -rf /var/lib/apt/lists/*

# Create a regular user
RUN useradd -m -s /bin/bash kali && \
    usermod -aG sudo kali

# Create the working directory
RUN mkdir -p /home/kali/project && \
    chown -R kali:kali /home/kali/project

# Set environment
ENV HOME=/home/kali

# Set working directory
WORKDIR /home/kali/project

# Use regular user by default
USER kali

# Start Bash
CMD ["/bin/bash"]
```

### Build the image

```bash
docker build -t secure-kali:1.0 .
```

### Run the container

```bash
docker run -dit \
  --name kali-training \
  --hostname kali-training \
  secure-kali:1.0
```

### Enter the container

```bash
docker exec -it kali-training bash
```

### Verify

```bash
whoami
pwd
hostname
```

Expected user:

```text
kali
```

**Why use a regular user?** Running applications as root increases the impact of mistakes or compromised processes.

# 13. Users and Permissions

Enter the container as root when administrative changes are needed:

```bash
docker exec -u root -it kali-training bash
```

Set a password for the regular user:

```bash
passwd kali
```

Set a root password:

```bash
passwd root
```

Check user information:

```bash
whoami
id
groups
```

Check permissions:

```bash
ls -la
```

### Configure sudo

As root:

```bash
visudo -f /etc/sudoers.d/kali
```

Add:

```text
kali ALL=(ALL:ALL) ALL
```

Save and validate:

```bash
chmod 440 /etc/sudoers.d/kali
visudo -c
```

Test:

```bash
su - kali
sudo whoami
```

**Security note:** Docker administrators can run commands as root inside containers. Container account passwords do not protect against someone who controls the Docker daemon.

Passwords set interactively are lost if the container is removed and recreated. Do not store plaintext passwords in a Dockerfile or Git repository.

# 14. Docker Networking

### List networks

```bash
docker network ls
```

### Inspect a network

```bash
docker network inspect bridge
```

### Create a network

```bash
docker network create lab-network
```

### Run a container on the network

```bash
docker run -dit \
  --name app-lab \
  --network lab-network \
  ubuntu bash
```

### Connect a container

```bash
docker network connect lab-network app-lab
```

### Disconnect a container

```bash
docker network disconnect lab-network app-lab
```

### Remove a network

```bash
docker network rm lab-network
```

**Why use custom networks?** They allow containers to communicate with each other using container names.

# 15. Port Mapping

Example:

```bash
docker run -d \
  --name web-lab \
  -p 8080:80 \
  nginx
```

Port mapping:

- Host port: `8080`
- Container port: `80`

Open:

```text
http://localhost:8080
```

Check port mappings:

```bash
docker port web-lab
```

**Security note:** Published ports may be accessible outside the host depending on firewall and network configuration. Publish only necessary ports.

# 16. Docker Volumes

Containers are replaceable. Data stored only in a container's writable layer can be lost when the container is removed.

### Create a volume

```bash
docker volume create lab-data
```

### List volumes

```bash
docker volume ls
```

### Inspect a volume

```bash
docker volume inspect lab-data
```

### Mount a volume

```bash
docker run -dit \
  --name volume-lab \
  -v lab-data:/data \
  ubuntu bash
```

Inside the container:

```bash
echo "Docker volume test" > /data/test.txt
cat /data/test.txt
```

Remove the container:

```bash
docker rm -f volume-lab
```

Create another container using the same volume:

```bash
docker run --rm \
  -v lab-data:/data \
  ubuntu cat /data/test.txt
```

The file should still exist.

### Remove a volume

```bash
docker volume rm lab-data
```

Only remove volumes when their data is no longer required.

# 17. Bind Mounts

Bind mounts connect a host directory to a container directory.

Create a directory:

```bash
mkdir -p ~/docker-share
```

Run:

```bash
docker run --rm -it \
  -v ~/docker-share:/data \
  ubuntu bash
```

Inside the container:

```bash
echo "Shared file" > /data/example.txt
```

On the host:

```bash
cat ~/docker-share/example.txt
```

**Why use bind mounts?** They allow you to edit files on the host and access them inside a container.

# 18. Resource Management

### Set memory limit

```bash
docker run -dit \
  --name memory-lab \
  --memory="512m" \
  ubuntu bash
```

### Set CPU limit

```bash
docker run -dit \
  --name cpu-lab \
  --cpus="1.0" \
  ubuntu bash
```

### Set CPU and memory limits

```bash
docker run -dit \
  --name resource-lab \
  --memory="512m" \
  --cpus="1.0" \
  ubuntu bash
```

**Why set limits?** Resource limits help prevent one container from consuming excessive host resources.

# 19. Resource Monitoring

### Before running a container

```bash
docker system df
docker ps -a
free -h
df -h
```

These commands show Docker storage, existing containers, available memory, and disk space.

### Monitor live usage

```bash
docker stats
```

Shows:

- CPU usage
- Memory usage
- Network I/O
- Block I/O
- Process count

### Monitor one container

```bash
docker stats kali-training
```

### View container processes

```bash
docker top kali-training
```

### Check container size

```bash
docker ps -s
```

### During execution

```bash
docker stats
docker top resource-lab
docker logs resource-lab
```

### After execution

```bash
docker ps -a
docker inspect resource-lab
docker system df
```

**Important:** `docker stats` reports live container resource usage. `docker system df` reports Docker storage usage, not RAM usage.

# 20. Docker Security Checks

Use these checks on containers and images you own or are authorized to inspect.

### Check running containers

```bash
docker ps
```

### Check privileged mode

```bash
docker inspect \
  -f '{{.HostConfig.Privileged}}' kali-training
```

Expected for a normal lab container:

```text
false
```

### Check configured user

```bash
docker inspect \
  -f '{{.Config.User}}' kali-training
```

### Check published ports

```bash
docker port kali-training
```

### Check added capabilities

```bash
docker inspect \
  -f '{{.HostConfig.CapAdd}}' kali-training
```

### Check mounted directories

```bash
docker inspect \
  -f '{{json .Mounts}}' kali-training
```

### Check restart policy

```bash
docker inspect \
  -f '{{.HostConfig.RestartPolicy.Name}}' kali-training
```

### Review logs

```bash
docker logs --tail 100 kali-training
```

### Review image history

```bash
docker history secure-kali:1.0
```

### Inspect image metadata

```bash
docker image inspect secure-kali:1.0
```

# 21. Docker Security Best Practices

1. Use trusted and maintained base images.
2. Prefer specific image tags instead of relying on `latest`.
3. Run applications as non-root where possible.
4. Avoid `--privileged` unless absolutely necessary.
5. Avoid mounting sensitive host directories.
6. Publish only required ports.
7. Set CPU and memory limits for workloads.
8. Keep images and packages updated.
9. Do not store passwords, tokens, or private keys in images.
10. Use `.dockerignore` to exclude unnecessary files.
11. Review image layers and container configuration.
12. Remove unused containers, images, and networks.
13. Back up important volumes.
14. Use read-only filesystems where supported.

# 22. Logs and Troubleshooting

### View logs

```bash
docker logs kali-training
```

### Follow logs live

```bash
docker logs -f kali-training
```

### View the last 50 lines

```bash
docker logs --tail 50 kali-training
```

### View Docker events

```bash
docker events
```

### Inspect a container

```bash
docker inspect kali-training
```

### Check Docker service

```bash
sudo systemctl status docker
```

### Restart Docker service

```bash
sudo systemctl restart docker
```

Restarting Docker can affect running containers, so use it carefully.

# 23. Docker Compose

Docker Compose manages applications made up of multiple containers.

Create a directory:

```bash
mkdir compose-lab
cd compose-lab
```

Create `compose.yaml`:

```yaml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    restart: unless-stopped

  app:
    image: ubuntu:24.04
    command: ["sleep", "infinity"]
    restart: unless-stopped
```

### Start services

```bash
docker compose up -d
```

### List services

```bash
docker compose ps
```

### View logs

```bash
docker compose logs
```

### Stop services

```bash
docker compose stop
```

### Stop and remove containers and network

```bash
docker compose down
```

**Why use Compose?** It stores multi-container configuration in one file, making environments easier to reproduce.

# 24. Docker Cleanup

### Remove stopped containers

```bash
docker container prune
```

### Remove unused networks

```bash
docker network prune
```

### Remove dangling images

```bash
docker image prune
```

### Remove unused build cache

```bash
docker builder prune
```

### General cleanup

```bash
docker system prune
```

### Include unused volumes

```bash
docker system prune --volumes
```

**Warning:** Cleanup commands can delete resources and data. Review what will be removed before confirming. Back up important volumes first.

# 25. Useful Docker Aliases

Add these to `~/.bashrc`:

```bash
# Short Docker command
alias d='docker'

# List running containers
alias dps='docker ps'

# List all containers
alias dpa='docker ps -a'

# List images
alias di='docker images'

# Live resource usage
alias dstats='docker stats'

# Docker storage usage
alias ddf='docker system df'

# View container logs
alias dlogs='docker logs'
```

Reload:

```bash
source ~/.bashrc
```

Test:

```bash
dps
di
```

# 26. Docker Project Structure

Recommended repository structure:

```text
Docker-Training/
├── README.md
├── Dockerfile
├── compose.yaml
├── .dockerignore
├── .gitignore
├── scripts/
│   └── kali
├── examples/
│   ├── ubuntu/
│   │   └── Dockerfile
│   └── kali/
│       └── Dockerfile
└── screenshots/
```

Create the structure:

```bash
mkdir -p Docker-Training/{scripts,examples/ubuntu,examples/kali,screenshots}

cd Docker-Training

touch README.md Dockerfile compose.yaml
touch .dockerignore .gitignore
touch scripts/kali
touch examples/ubuntu/Dockerfile
touch examples/kali/Dockerfile
```

# 27. Docker Ignore Files

### .dockerignore

Create `.dockerignore`:

```text
.git
.github
.env
*.key
*.pem
*.log
screenshots/
```

**Why?** Prevents unnecessary files from entering the Docker build context.

Do not put secrets in the build context in the first place.

### .gitignore

Create `.gitignore`:

```text
.env
*.key
*.pem
*.log
*.tar
*.tar.gz
.DS_Store
```

**Why?** Helps prevent local files and credentials from being committed to Git.

Never commit private SSH keys or passwords.

# 28. Git and GitHub

### Check repository status

```bash
git status
```

### Add files

```bash
git add .
```

### Commit changes

```bash
git commit -m "Add Docker training guide and examples"
```

### Check branch

```bash
git branch
```

### Rename branch

```bash
git branch -M main
```

### Check remote

```bash
git remote -v
```

### Add remote if not configured

```bash
git remote add origin git@github.com:Faqdot/Docker-Training.git
```

If the remote already exists, update it:

```bash
git remote set-url origin git@github.com:Faqdot/Docker-Training.git
```

### Push to GitHub

```bash
git push -u origin main
```

# 29. Common Errors

### Docker daemon not running

Check:

```bash
sudo systemctl status docker
```

Start:

```bash
sudo systemctl start docker
```

### Permission denied

Try:

```bash
sudo docker ps
```

If configuring Docker group access, log out and back in after adding your user to the group.

### Container name already exists

Check:

```bash
docker ps -a
```

Remove the old container only if it is no longer needed:

```bash
docker rm old-container
```

### Image is being used by a container

Check:

```bash
docker ps -a
```

Remove the dependent container if it is no longer needed, then remove the image.

### Port already allocated

Check:

```bash
sudo ss -lntp
```

Choose another available host port.

### No space left on device

Check:

```bash
df -h
docker system df
```

Review unused resources before cleaning them up.

# 30. Quick Command Reference

| Task | Command |
|---|---|
| Docker version | `docker --version` |
| Docker details | `docker info` |
| Download image | `docker pull ubuntu` |
| List images | `docker images` |
| Run container | `docker run -it ubuntu bash` |
| List running containers | `docker ps` |
| List all containers | `docker ps -a` |
| Enter container | `docker exec -it NAME bash` |
| Stop container | `docker stop NAME` |
| Start container | `docker start NAME` |
| Remove container | `docker rm NAME` |
| Remove image | `docker rmi IMAGE` |
| Build image | `docker build -t NAME .` |
| Monitor resources | `docker stats` |
| Inspect container | `docker inspect NAME` |
| View logs | `docker logs NAME` |
| List networks | `docker network ls` |
| List volumes | `docker volume ls` |
| Docker disk usage | `docker system df` |
| Compose start | `docker compose up -d` |
| Compose stop/remove | `docker compose down` |

# 31. Practical Workflow

A typical custom Kali image workflow:

```bash
# 1. Go to the project directory
cd ~/project/Docker-Training

# 2. Build the custom image
docker build \
  -t secure-kali:1.0 \
  -f examples/kali/Dockerfile \
  examples/kali

# 3. Check the image
docker images

# 4. Create and start a container
docker run -dit \
  --name kali-training \
  secure-kali:1.0

# 5. Check running containers
docker ps

# 6. Enter the container
docker exec -it kali-training bash

# 7. Check user and working directory
whoami
pwd

# 8. Monitor resource usage
docker stats kali-training

# 9. Exit the container shell
exit

# 10. Stop the container
docker stop kali-training

# 11. Start it again when needed
docker start kali-training

# 12. Remove it only when no longer needed
docker rm -f kali-training

# 13. Remove the image only when no container depends on it
docker rmi secure-kali:1.0
```

**Remember:**

- `docker stop` stops a container but keeps it.
- `docker start` starts an existing stopped container.
- `docker rm` removes a container.
- `docker rmi` removes an image.
- Named volumes are separate from containers and can persist after container removal.

# 32. Learning Roadmap

Follow this order:

1. Install Docker.
2. Learn image commands.
3. Learn container lifecycle commands.
4. Practice `run`, `exec`, `stop`, `start`, and `rm`.
5. Write a basic Dockerfile.
6. Build and run a custom Ubuntu image.
7. Build a custom Kali image.
8. Learn users and permissions.
9. Practice networking and port mapping.
10. Practice volumes and bind mounts.
11. Monitor CPU, memory, and disk usage.
12. Perform basic container security checks.
13. Learn Docker Compose.
14. Learn cleanup and troubleshooting.
15. Publish your project to GitHub.

---

## Official Documentation

- Docker documentation: https://docs.docker.com/
- Docker Engine: https://docs.docker.com/engine/
- Dockerfile reference: https://docs.docker.com/reference/dockerfile/
- Docker Compose: https://docs.docker.com/compose/
- Docker security: https://docs.docker.com/engine/security/

## Learning Goal

After completing this guide, you should be able to:

- Install and configure Docker.
- Manage images and containers.
- Build custom Docker images.
- Create and manage Kali and Ubuntu containers.
- Configure users, permissions, networks, and volumes.
- Monitor container resource usage.
- Perform basic Docker security checks.
- Troubleshoot common Docker problems.
- Maintain and publish a Docker training project on GitHub.

**Note:** Use the Kali environment as an isolated learning lab. Only test systems and applications that you own or have explicit permission to assess.
