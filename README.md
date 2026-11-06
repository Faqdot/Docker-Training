# Docker A–Z: Complete Beginner-to-Practical Manual

**A practical guide to Docker, custom images, container management, security checks, resource monitoring, and GitHub project management.**

**Author:** Faqdot  
**Repository:** https://github.com/Faqdot/Docker-Training

---

# Table of Contents

1. Introduction to Docker
2. Docker Architecture
3. Prerequisites
4. Install Docker
5. Verify Docker
6. Docker Basic Concepts
7. Docker Command Structure
8. Docker Images
9. Docker Containers
10. Docker Container Lifecycle
11. Dockerfile – Build Custom Images
12. Build a Custom Kali Linux Image
13. Run and Access Kali Linux
14. Linux Users and Permissions
15. Docker Networking
16. Docker Volumes and Storage
17. Container Resource Management
18. Resource Monitoring Before and After Running
19. Docker Security Checks
20. Dockerfile Security
21. Container Security
22. Docker Logs and Troubleshooting
23. Docker Compose
24. Docker Cleanup and Maintenance
25. Docker Aliases and Shortcuts
26. Git and GitHub Setup
27. SSH Authentication
28. Save and Upload the Project
29. Terminal Input and Output Examples
30. Screenshots and Documentation
31. Common Errors and Solutions
32. Security Best Practices
33. Learning Checklist
34. Project Directory Structure
35. Useful Documentation

---

# 1. Introduction to Docker
 
Docker is a platform used to build, package, and run applications inside containers.

Containers allow applications to run in isolated environments with their required dependencies.

### Why use Docker?

- Run applications in isolated environments.
- Build custom application environments.
- Reduce dependency conflicts.
- Deploy applications consistently.
- Create repeatable development environments.
- Manage application resources.
- Test software without installing everything directly on the host.

### Example

Without Docker:

```text
Host Linux
   |
   +-- Application A
   +-- Application B
   +-- Dependencies
   +-- Configuration conflicts
```

With Docker:

```text
Host Linux
   |
   +-- Docker Engine
          |
          +-- Container A
          |     +-- Application A
          |     +-- Dependencies
          |
          +-- Container B
                +-- Application B
                +-- Dependencies
```

---

# 2. Docker Architecture

Docker uses a client-server architecture.

### Main components

| Component | Purpose |
|---|---|
| Docker Client | Accepts commands such as `docker run` |
| Docker Daemon | Manages Docker objects |
| Docker Images | Templates used to create containers |
| Docker Containers | Isolated application environments |
| Docker Registry | Stores Docker images |
| Docker Volumes | Stores persistent data |
| Docker Networks | Connects containers |

### Architecture diagram

```text
                Docker Client
                     |
                     | Docker commands
                     v
                Docker Daemon
                     |
          +----------+----------+
          |          |          |
          v          v          v
        Images   Containers   Networks
                     |
                     v
                  Volumes
                     |
                     v
                Persistent Data
```

---

# 3. Prerequisites

Prepare the following:

- Linux or WSL.
- Docker Engine or Docker Desktop.
- Git.
- GitHub account.
- Basic Bash knowledge.
- Internet connection for downloading images and packages.

Update your Linux system:

```bash
sudo apt update
sudo apt upgrade -y
```

Install useful utilities:

```bash
sudo apt install -y \
  git \
  curl \
  wget \
  nano \
  vim \
  openssh-client \
  ca-certificates
```

---

# 4. Install Docker

Follow the official Docker installation guide:

https://docs.docker.com/engine/install/

For Debian-based Linux systems, use the official Docker Engine installation instructions for your distribution.

After installation, check Docker:

```bash
docker --version
```

Check Docker service:

```bash
sudo systemctl status docker
```

Start Docker if necessary:

```bash
sudo systemctl start docker
```

Enable Docker at startup:

```bash
sudo systemctl enable docker
```

Check Docker information:

```bash
docker info
```

> On Docker Desktop with WSL integration, Docker may be managed by Docker Desktop rather than by a Docker service inside WSL.

---

# 5. Verify Docker

Run the official test image:

```bash
sudo docker run hello-world
```

Expected output:

```text
Hello from Docker!

This message shows that your installation appears
to be working correctly.
```

Check the Docker version:

```bash
docker --version
```

Example:

``text
Docker version 29.x.x, build xxxxxxx
``

Check available images:

```bash
docker images
```

Check running containers:

```bash
docker ps
```

---

# 6. Docker Basic Concepts

| Term | Simple explanation |
|---|---|
| Image | Template for creating a container |
| Container | An instance created from an image |
| Dockerfile | Instructions for building an image |
| Volume | Persistent storage |
| Network | Container communication |
| Registry | Image storage service |
| Compose | Tool for managing multiple containers |
| Daemon | Background service managing Docker |

### Important difference: Image vs Container

```text
Docker Image
     |
     | docker run
     v
Docker Container
     |
     | docker start / stop
     v
Container Lifecycle
```

An image is a template. A container is created from that template.

---

# 7. Docker Command Structure

General format:

```bash
docker COMMAND OPTIONS ARGUMENTS
```

Examples:

```bash
docker images
docker ps
docker pull ubuntu
docker run -it ubuntu bash
docker exec -it CONTAINER bash
```

### Common Docker flags

| Flag | Meaning |
|---|---|
| `-i` | Keep standard input open |
| `-t` | Allocate a terminal |
| `-it` | Interactive terminal |
| `-d` | Run in background |
| `-p` | Publish a port |
| `-v` | Mount a volume |
| `--rm` | Remove container after it exits |
| `--name` | Set container name |
| `--hostname` | Set container hostname |
| `--workdir` | Set working directory |
| `--memory` | Set memory limit |
| `--cpus` | Set CPU limit |
| `--restart` | Configure restart behavior |
| `--read-only` | Make container root filesystem read-only |

---

# 8. Docker Images

Images are templates used to create containers.

## 8.1 Download an image

```bash
docker pull ubuntu
```

Download Kali Linux:

```bash
docker pull kalilinux/kali-rolling
```

## 8.2 List images

```bash
docker images
```

Example:

```text
REPOSITORY             TAG       IMAGE ID       SIZE
ubuntu                 latest    abc123456789   78MB
kalilinux/kali-rolling latest    def987654321   150MB
```

## 8.3 Inspect an image

```bash
docker image inspect ubuntu
```

## 8.4 View image history

```bash
docker history ubuntu
```

## 8.5 Tag an image

```bash
docker tag ubuntu my-ubuntu:v1
```

## 8.6 Remove an image

```bash
docker rmi IMAGE_ID
```

If a container still uses the image, remove the container first if it is no longer needed.

---

# 9. Docker Containers

## 9.1 Create and run a container

```bash
docker run -it --name ubuntu-lab ubuntu bash
```

This creates a container and opens an interactive shell.

## 9.2 Run a container in the background

```bash
docker run -dit --name ubuntu-background ubuntu bash
```

## 9.3 List running containers

```bash
docker ps
```

## 9.4 List all containers

```bash
docker ps -a
```

## 9.5 Access a running container

```bash
docker exec -it ubuntu-background bash
```

## 9.6 Stop a container

```bash
docker stop ubuntu-background
```

## 9.7 Start a stopped container

```bash
docker start ubuntu-background
```

## 9.8 Restart a container

```bash
docker restart ubuntu-background
```

## 9.9 Remove a container

```bash
docker rm ubuntu-background
```

## 9.10 Force remove a container

```bash
docker rm -f ubuntu-background
```

**Remember:**

- `docker rm` removes containers.
- `docker rmi` removes images.

---

# 10. Docker Container Lifecycle

```text
        Create
          |
          v
        Created
          |
          v
        Running
          |
       +--+--+
       |     |
       v     v
     Pause  Stop
       |     |
       v     v
    Paused  Exited
       |     |
       v     v
    Unpause  Start
       |     |
       +-----+
          |
          v
        Running
          |
          v
        Remove
```

Useful commands:

```bash
docker create --name test ubuntu
docker start test
docker pause test
docker unpause test
docker stop test
docker restart test
docker rm test
```

Inspect lifecycle state:

```bash
docker inspect -f '{{.State.Status}}' test
```

---

# 11. Dockerfile – Build Custom Images

A Dockerfile contains instructions for creating a custom Docker image.

### Common Dockerfile instructions

| Instruction | Purpose |
|---|---|
| `FROM` | Select base image |
| `RUN` | Execute build-time commands |
| `COPY` | Copy local files into image |
| `ADD` | Add files or remote resources |
| `WORKDIR` | Set working directory |
| `ENV` | Set environment variables |
| `USER` | Set default user |
| `EXPOSE` | Document application port |
| `CMD` | Default command |
| `ENTRYPOINT` | Main container executable |
| `ARG` | Build-time variable |
| `LABEL` | Add image metadata |

### Example Dockerfile

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["/bin/bash"]
```

Build the image:

```bash
docker build -t custom-ubuntu .
```

Run it:

```bash
docker run -it --name custom-test custom-ubuntu
```

---

# 12. Build a Custom Kali Linux Image

This section creates a reusable Kali Linux lab environment.

## 12.1 Create a project directory

```bash
mkdir -p ~/project/kali-docker
cd ~/project/kali-docker
```

## 12.2 Create the Dockerfile

```bash
nano Dockerfile
```

Add:

```dockerfile
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    sudo \
    passwd \
    bash \
    nano \
    vim \
    curl \
    wget \
    git \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create regular user
RUN useradd -m -s /bin/bash kali \
    && usermod -aG sudo kali

# Create project directory
RUN mkdir -p /home/dev/project \
    && chown -R kali:kali /home/dev

ENV HOME=/home/kali

WORKDIR /home/dev/project

USER kali

CMD ["/bin/bash"]
```

## 12.3 Build the custom image

```bash
docker build -t secure-kali .
```

## 12.4 Check the image

```bash
docker images
```

## 12.5 Run the container

```bash
docker run -dit \
  --name kali-container \
  --hostname kali-training \
  secure-kali
```

## 12.6 Enter the container

```bash
docker exec -it kali-container bash
```

Check:

```bash
whoami
hostname
pwd
```

Expected:

```text
kali
kali-training
/home/dev/project
```

> This image creates a regular user but does not set a password. Configure passwords interactively after creation, or use a secure secrets-management process. Never put plain-text passwords into a Dockerfile.

---

# 13. Linux Users and Permissions

Enter as root:

```bash
docker exec -u root -it kali-container bash
```

Check users:

```bash
cat /etc/passwd
```

Check groups:

```bash
groups kali
```

Set the root password:

```bash
passwd root
```

Set the Kali user password:

```bash
passwd kali
```

Configure sudo:

```bash
visudo -f /etc/sudoers.d/kali
```

Add:

```text
kali ALL=(ALL:ALL) ALL
```

Set permissions:

```bash
chmod 440 /etc/sudoers.d/kali
visudo -c
```

Test:

```bash
su - kali
sudo whoami
```

Expected:

```text
root
```

---

# 14. Docker Networking

Docker networks allow containers to communicate.

## 14.1 List networks

```bash
docker network ls
```

## 14.2 Inspect a network

```bash
docker network inspect bridge
```

## 14.3 Create a custom network

```bash
docker network create lab-network
```

## 14.4 Run a container on the network

```bash
docker run -dit \
  --name lab-one \
  --network lab-network \
  ubuntu bash
```

## 14.5 Connect another container

```bash
docker run -dit \
  --name lab-two \
  --network lab-network \
  ubuntu bash
```

Inspect the network:

```bash
docker network inspect lab-network
```

## 14.6 Publish a port

```bash
docker run -d \
  --name web-test \
  -p 127.0.0.1:8080:80 \
  nginx
```

Visit:

```text
http://127.0.0.1:8080
```

The `127.0.0.1` binding keeps this example accessible from the local machine rather than exposing it on every network interface.

---

# 15. Docker Volumes and Storage

Containers can be removed and recreated. Volumes help preserve data.

## 15.1 List volumes

```bash
docker volume ls
```

## 15.2 Create a volume

```bash
docker volume create kali-data
```

## 15.3 Inspect a volume

```bash
docker volume inspect kali-data
```

## 15.4 Mount a volume

```bash
docker run -dit \
  --name volume-test \
  -v kali-data:/data \
  ubuntu bash
```

Enter:

```bash
docker exec -it volume-test bash
```

Create a file:

```bash
echo "Docker persistent data" > /data/test.txt
```

Exit and remove the container:

```bash
exit
docker rm -f volume-test
```

Create another container using the same volume:

```bash
docker run --rm \
  -v kali-data:/data \
  ubuntu cat /data/test.txt
```

Expected:

```text
Docker persistent data
```

The volume retains its data after the original container is removed.

---

# 16. Container Resource Management

Docker allows resource limits to be configured for containers.

Important resources:

- CPU
- Memory
- Storage
- Processes
- Network usage
- Open file descriptors

## 16.1 Set a memory limit

```bash
docker run -dit \
  --name memory-test \
  --memory=512m \
  ubuntu bash
```

This sets a 512 MB memory limit.

## 16.2 Set a CPU limit

```bash
docker run -dit \
  --name cpu-test \
  --cpus=1.5 \
  ubuntu bash
```

This limits the container to a maximum CPU allocation equivalent to 1.5 CPUs.

## 16.3 Set memory and CPU together

```bash
docker run -dit \
  --name resource-test \
  --memory=512m \
  --cpus=1.0 \
  ubuntu bash
```

## 16.4 Set a restart policy

```bash
docker run -dit \
  --name restart-test \
  --restart=unless-stopped \
  ubuntu bash
```

Common restart policies:

| Policy | Behavior |
|---|---|
| `no` | No automatic restart |
| `on-failure` | Restart after a failure |
| `always` | Always restart |
| `unless-stopped` | Restart unless manually stopped |

## 16.5 Check container resource usage

```bash
docker stats
```

Example:

```text
CONTAINER ID   NAME            CPU %   MEM USAGE / LIMIT
abc123         resource-test   0.20%   45MiB / 512MiB
```

## 16.6 Inspect configured resource limits

```bash
docker inspect resource-test
```

Focused memory and CPU output:

```bash
docker inspect -f \
'Memory={{.HostConfig.Memory}} NanoCPUs={{.HostConfig.NanoCpus}}' \
resource-test
```

## 16.7 Check process usage

```bash
docker top resource-test
```

## 16.8 Check disk usage

```bash
docker system df
```

## 16.9 Check filesystem usage inside a container

```bash
docker exec resource-test df -h
```

## 16.10 Check host resources

```bash
free -h
df -h
top
```

For a more convenient process viewer, install:

```bash
sudo apt install -y htop
```

Run:

```bash
htop
```

---

# 17. Resource Monitoring Before and After Running

Resource monitoring should be done before, during, and after a container runs.

## Before running a container

Check host memory:

```bash
free -h
```

Check host disk space:

```bash
df -h
```

Check CPU and processes:

```bash
top
```

Check Docker disk usage:

```bash
docker system df
```

Check existing containers:

```bash
docker ps -a
```

Record the results.

## Start a test container

```bash
docker run -dit \
  --name resource-lab \
  --memory=512m \
  --cpus=1.0 \
  ubuntu bash
```

## While the container is running

Check live usage:

```bash
docker stats resource-lab
```

Check processes:

```bash
docker top resource-lab
```

Check configuration:

```bash
docker inspect resource-lab
```

## Stop the container

```bash
docker stop resource-lab
```

Check status:

```bash
docker ps -a
```

## After stopping

Check host memory:

```bash
free -h
```

Check Docker storage:

```bash
docker system df
```

Remove the test container when no longer needed:

```bash
docker rm resource-lab
```

### Resource monitoring comparison

| Stage | Commands | What to observe |
|---|---|---|
| Before | `free -h`, `df -h` | Host memory and disk |
| Before | `docker system df` | Docker storage usage |
| Running | `docker stats` | Container CPU and memory |
| Running | `docker top` | Container processes |
| After | `free -h`, `df -h` | Host resource state |
| After | `docker system df` | Docker storage state |

> Stopping a container does not necessarily free its writable storage. Removing a container can remove that container's writable layer, but named volumes remain until separately removed. Host memory and CPU readings can also vary due to other running processes.

---

# 18. Docker Security Checks

Security checks help identify configuration risks and unexpected container behavior.

Only inspect systems and containers you own or are authorized to manage.

## 18.1 Docker version

```bash
docker version
```

## 18.2 Docker system information

```bash
docker info
```

## 18.3 Inspect image configuration

```bash
docker image inspect secure-kali
```

## 18.4 Inspect container configuration

```bash
docker inspect kali-container
```

## 18.5 Check the running user

```bash
docker exec kali-container whoami
```

## 18.6 Check container processes

```bash
docker top kali-container
```

## 18.7 Check exposed ports

```bash
docker port kali-container
```

## 18.8 Check container logs

```bash
docker logs kali-container
```

Follow logs:

```bash
docker logs -f kali-container
```

## 18.9 Check privileged mode

```bash
docker inspect -f '{{.HostConfig.Privileged}}' kali-container
```

For an ordinary lab container, the expected result is:

```text
false
```

## 18.10 Check mounted volumes

```bash
docker inspect -f '{{json .Mounts}}' kali-container
```

## 18.11 Check capabilities

```bash
docker inspect -f '{{json .HostConfig.CapAdd}}' kali-container
```

## 18.12 Check security options

```bash
docker inspect -f '{{json .HostConfig.SecurityOpt}}' kali-container
```

## 18.13 Run Docker's built-in security benchmark

Docker Bench for Security is a community-maintained audit tool that checks many Docker host configuration recommendations.

Project:

https://github.com/docker/docker-bench-security

Read its documentation and review its audit behavior before running it. Use it only on systems you administer.

## 18.14 Scan an image for known vulnerabilities

Use Docker Scout where available:

```bash
docker scout quickview secure-kali
```

For a more detailed CVE report:

```bash
docker scout cves secure-kali
```

Availability depends on your Docker installation and account access.

> Vulnerability scanners can report known package vulnerabilities. A clean scan does not guarantee that an image or application is secure.

---

# 19. Dockerfile Security

Good Dockerfile practices:

1. Use trusted base images.
2. Prefer supported image versions.
3. Avoid installing unnecessary packages.
4. Remove package manager cache.
5. Run as a non-root user where possible.
6. Do not store passwords in image layers.
7. Do not copy private keys into an image.
8. Do not use secrets as build arguments.
9. Keep image size reasonable.
10. Rebuild images to receive security updates.

### Example safer Dockerfile

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash appuser

WORKDIR /home/appuser

USER appuser

CMD ["/bin/bash"]
```

Build:

```bash
docker build -t safer-ubuntu .
```

Check the configured user:

```bash
docker image inspect -f '{{.Config.User}}' safer-ubuntu
```

Expected:

```text
appuser
```

---

# 20. Container Security

Useful security options include:

### Run as a non-root user

```bash
docker run -it --user 1000:1000 ubuntu bash
```

This example assumes that the image and selected directory support that user ID.

### Drop unnecessary Linux capabilities

```bash
docker run -it \
  --cap-drop=ALL \
  ubuntu bash
```

Some applications need specific capabilities. Add only the capabilities required for the workload.

### Use a read-only root filesystem

```bash
docker run -it \
  --read-only \
  --tmpfs /tmp \
  ubuntu bash
```

### Limit resources

```bash
docker run -dit \
  --memory=512m \
  --cpus=1 \
  ubuntu bash
```

### Avoid privileged containers

Do not use `--privileged` unless there is a clear, authorized requirement. It grants broad access to host resources and weakens container isolation.

### Important note

Containers provide isolation, but they are not a replacement for host security. Keep the host updated and protect access to the Docker daemon.

---

# 21. Docker Logs and Troubleshooting

## View logs

```bash
docker logs CONTAINER_NAME
```

## Follow logs live

```bash
docker logs -f CONTAINER_NAME
```

## Show the latest 50 lines

```bash
docker logs --tail 50 CONTAINER_NAME
```

## Inspect container status

```bash
docker inspect CONTAINER_NAME
```

## Check container processes

```bash
docker top CONTAINER_NAME
```

## Check events

```bash
docker events
```

## Check disk usage

```bash
docker system df
```

## Check Docker daemon status

```bash
sudo systemctl status docker
```

---

# 22. Docker Compose

Docker Compose manages applications containing multiple services.

Create a directory:

```bash
mkdir compose-lab
cd compose-lab
```

Create `compose.yaml`:

```yaml
services:
  web:
    image: nginx:stable
    ports:
      - "127.0.0.1:8080:80"
    restart: unless-stopped
```

Start:

```bash
docker compose up -d
```

List services:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs
```

Stop:

```bash
docker compose down
```

The example uses a locally bound port. This is suitable for a local learning environment.

---

# 23. Docker Cleanup and Maintenance

## Remove a container

```bash
docker rm CONTAINER_NAME
```

<<<<<<< HEAD
**FAQ**
=======
## Remove an image
>>>>>>> 8b2985e (Update README file)

```bash
docker rmi IMAGE_ID
```

## Remove unused containers and networks

```bash
docker system prune
```

## Remove unused images too

```bash
docker system prune -a
```

## List volumes

```bash
docker volume ls
```

## Remove a specific unused volume

```bash
docker volume rm VOLUME_NAME
```

## Check disk usage

```bash
docker system df
```

> Be careful with prune and volume-removal commands. They can permanently delete data. Never remove a volume until you have confirmed it does not contain data you need.

---

# 24. Docker Aliases and Shortcuts

Open Bash configuration:

```bash
nano ~/.bashrc
```

Add:

```bash
# Docker shortcut
alias d='docker'

# Container shortcuts
alias dps='docker ps'
alias dpa='docker ps -a'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'
alias dexec='docker exec -it'

# Image shortcuts
alias di='docker images'
alias dpull='docker pull'
alias drmi='docker rmi'

# Resource monitoring
alias dstats='docker stats'
alias ddf='docker system df'
```

Reload:

```bash
source ~/.bashrc
```

Examples:

```bash
d ps
d ps -a
d images
d stats
d system df
```

---

# 25. Git and GitHub Setup

Git tracks changes in project files. GitHub hosts Git repositories online.

Install Git:

```bash
sudo apt update
sudo apt install -y git
```

Configure identity:

```bash
git config --global user.name "Faqdot"
git config --global user.email "YOUR_GITHUB_EMAIL"
```

Check:

```bash
git config --global --list
```

Create a project directory:

```bash
mkdir -p ~/project/Docker-Training
cd ~/project/Docker-Training
```

Initialize Git:

```bash
git init
```

Check status:

```bash
git status
```

---

# 26. SSH Authentication

Check SSH keys:

```bash
ls -la ~/.ssh
```

Generate an Ed25519 key if needed:

```bash
ssh-keygen -t ed25519 -C "YOUR_GITHUB_EMAIL"
```

Start the agent:

```bash
eval "$(ssh-agent -s)"
```

Add the private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the public key to:

https://github.com/settings/keys

Test:

```bash
ssh -T git@github.com
```

Expected:

```text
Hi Faqdot! You've successfully authenticated,
but GitHub does not provide shell access.
```

**Never upload the private key.** Only the `.pub` public key belongs in GitHub.

---

# 27. Save and Upload the Project to GitHub

Create a GitHub repository:

```text
Docker-Training
```

Repository:

https://github.com/Faqdot/Docker-Training

Set the SSH remote:

```bash
git remote add origin git@github.com:Faqdot/Docker-Training.git
```

If a remote already exists:

```bash
git remote set-url origin git@github.com:Faqdot/Docker-Training.git
```

Check:

```bash
git remote -v
```

Add project files:

```bash
git add .
```

Commit:

```bash
git commit -m "Initial Docker training project"
```

Set the branch name:

```bash
git branch -M main
```

Push:

```bash
git push -u origin main
```

For later changes:

```bash
git add .
git commit -m "Update Docker manual"
git push
```

---

# 28. Terminal Input and Output Examples

The outputs below are illustrative. Your IDs, resource values, timestamps, and versions will differ.

## Example 1 – Docker Version

Input:

```bash
docker --version
```

Output:

```text
Docker version 28.x.x, build xxxxxxx
```

## Example 2 – List Images

Input:

```bash
docker images
```

Output:

```text
REPOSITORY   TAG       IMAGE ID       SIZE
ubuntu       latest    abc123456789   78MB
secure-kali  latest    def987654321   1.2GB
```

## Example 3 – List Containers

Input:

```bash
docker ps -a
```

Output:

```text
CONTAINER ID   IMAGE        STATUS          NAMES
abc123         secure-kali  Up 5 minutes    kali-container
def456         ubuntu       Exited          ubuntu-lab
```

## Example 4 – Check Current User

Input:

```bash
whoami
```

Output:

```text
kali
```

## Example 5 – Check Hostname

Input:

```bash
hostname
```

Output:

```text
kali-training
```

## Example 6 – Check Working Directory

Input:

```bash
pwd
```

Output:

```text
/home/dev/project
```

## Example 7 – Check CPU and Memory

Input:

```bash
docker stats --no-stream
```

Illustrative output:

```text
CONTAINER ID   NAME            CPU %   MEM USAGE / LIMIT
abc123         kali-container  0.20%   65MiB / 512MiB
```

## Example 8 – Check Image User

Input:

```bash
docker image inspect -f '{{.Config.User}}' secure-kali
```

Output:

```text
kali
```

## Example 9 – Check Git Status

Input:

```bash
git status
```

Output:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

## Example 10 – Check GitHub SSH

Input:

```bash
ssh -T git@github.com
```

Output:

```text
Hi Faqdot! You've successfully authenticated,
but GitHub does not provide shell access.
```

---

# 29. Screenshots and Documentation

Screenshots provide visual evidence that each step was completed.

Create a screenshot directory:

```bash
mkdir -p screenshots
```

Recommended screenshot list:

| File | Screenshot content |
|---|---|
| `01-docker-version.png` | Docker version |
| `02-hello-world.png` | Hello World test |
| `03-docker-images.png` | Downloaded images |
| `04-docker-containers.png` | Container list |
| `05-custom-image-build.png` | Docker image build |
| `06-kali-container.png` | Kali terminal |
| `07-kali-user.png` | Regular user |
| `08-sudo-test.png` | Sudo authentication |
| `09-network.png` | Docker network |
| `10-volumes.png` | Docker volumes |
| `11-resource-stats.png` | Docker stats |
| `12-security-check.png` | Container inspection |
| `13-git-status.png` | Git status |
| `14-ssh-authentication.png` | SSH test |
| `15-github-repository.png` | GitHub repository |

Display screenshots in Markdown:

```markdown
## Docker Version

![Docker Version](screenshots/01-docker-version.png)

## Docker Images

![Docker Images](screenshots/03-docker-images.png)

## Kali Container

![Kali Container](screenshots/06-kali-container.png)

## Resource Monitoring

![Docker Resource Stats](screenshots/11-resource-stats.png)

## GitHub SSH Authentication

![SSH Authentication](screenshots/14-ssh-authentication.png)
```

Add screenshots to Git:

```bash
git add screenshots/
git commit -m "Add Docker lab screenshots"
git push
```

Only use real screenshots from your own environment. Sample command outputs in this manual are not screenshots or proof of successful execution.

---

# 30. Common Errors and Solutions

## Docker command not found

Check:

```bash
docker --version
```

Install Docker if it is missing.

## Cannot connect to Docker daemon

Check:

```bash
sudo systemctl status docker
```

Start the service if necessary:

```bash
sudo systemctl start docker
```

## Container name already exists

Check:

```bash
docker ps -a
```

Remove the old container if no longer needed:

```bash
docker rm -f kali-container
```

## Image is being used by a container

Find the container:

```bash
docker ps -a
```

Remove the relevant container if it is no longer needed, then remove the image.

## User does not exist

Check:

```bash
cat /etc/passwd
```

Create the user as root:

```bash
useradd -m -s /bin/bash kali
```

## Permission denied

Check the current user:

```bash
whoami
```

Check file permissions:

```bash
ls -l
```

## Git push rejected

Check:

```bash
git status
git branch
git remote -v
```

Pull remote changes when appropriate, resolve conflicts, then commit and push.

## SSH permission denied

Check:

```bash
ssh-add -l
```

Test:

```bash
ssh -T git@github.com
```

Make sure the matching public key is registered with GitHub.

---

# 31. Security Best Practices

- Use trusted base images.
- Keep the Docker host updated.
- Avoid running applications as root.
- Do not use privileged containers unnecessarily.
- Set CPU and memory limits.
- Avoid exposing unnecessary ports.
- Do not store secrets in Dockerfiles.
- Never commit private SSH keys.
- Use persistent volumes for important data.
- Inspect images before using them.
- Scan images for known vulnerabilities.
- Keep container privileges as limited as practical.
- Review Docker networks and published ports.
- Back up important volumes.
- Only test systems for which you have permission.

---

# 32. Learning Checklist

## Docker Fundamentals

- [ ] Install Docker.
- [ ] Verify Docker.
- [ ] Understand Docker architecture.
- [ ] Download images.
- [ ] List images.
- [ ] Inspect images.
- [ ] Run containers.
- [ ] Start and stop containers.
- [ ] Remove containers.
- [ ] Remove images.

## Custom Images

- [ ] Understand Dockerfile instructions.
- [ ] Create a Dockerfile.
- [ ] Build a custom image.
- [ ] Run the custom image.
- [ ] Inspect the image.
- [ ] Use a non-root user.

## Container Management

- [ ] Manage container lifecycle.
- [ ] Configure networking.
- [ ] Configure volumes.
- [ ] Set CPU limits.
- [ ] Set memory limits.
- [ ] Monitor Docker resources.
- [ ] Inspect logs and processes.
- [ ] Clean up unused resources.

## Security

- [ ] Inspect container privileges.
- [ ] Check user permissions.
- [ ] Check mounted volumes.
- [ ] Review published ports.
- [ ] Scan images.
- [ ] Avoid privileged mode.
- [ ] Avoid storing secrets in images.

## Git and GitHub

- [ ] Install Git.
- [ ] Configure Git identity.
- [ ] Initialize a repository.
- [ ] Create an SSH key.
- [ ] Register public key with GitHub.
- [ ] Test SSH authentication.
- [ ] Commit changes.
- [ ] Push to GitHub.
- [ ] Add screenshots to README.

---

# 33. Project Directory Structure

Recommended repository structure:

```text
Docker-Training/
│
├── README.md
│
├── Dockerfile
│
├── compose.yaml
│
├── .dockerignore
│
├── .gitignore
│
├── scripts/
│   └── kali
│
├── examples/
│   ├── ubuntu/
│   │   └── Dockerfile
│   │
│   └── kali/
│       └── Dockerfile
│
└── screenshots/
    ├── 01-docker-version.png
    ├── 02-hello-world.png
    ├── 03-docker-images.png
    ├── 04-docker-containers.png
    ├── 05-custom-image-build.png
    ├── 06-kali-container.png
    ├── 07-kali-user.png
    ├── 08-sudo-test.png
    ├── 09-network.png
    ├── 10-volumes.png
    ├── 11-resource-stats.png
    ├── 12-security-check.png
    ├── 13-git-status.png
    ├── 14-ssh-authentication.png
    └── 15-github-repository.png
```

### Example `.dockerignore`

```text
.git
.gitignore
.env
.env.*
*.log
*.tmp
screenshots/
```

### Example `.gitignore`

```text
# Secrets
.env
.env.*
*.pem
*.key

# Private SSH keys
id_ed25519
id_rsa
github

# Temporary files
*.log
*.tmp

# Editor folders
.vscode/
.idea/
```

Do not commit private keys, passwords, tokens, or other secrets.

---

# 34. Useful Documentation

| Resource | Link |
|---|---|
| Docker Documentation | https://docs.docker.com/ |
| Docker Engine | https://docs.docker.com/engine/ |
| Docker Hub | https://hub.docker.com/ |
| Docker Compose | https://docs.docker.com/compose/ |
| Docker Security | https://docs.docker.com/engine/security/ |
| Docker Scout | https://docs.docker.com/scout/ |
| Kali Linux Documentation | https://www.kali.org/docs/ |
| Git Documentation | https://git-scm.com/doc |
| GitHub Documentation | https://docs.github.com/ |
| GitHub SSH Guide | https://docs.github.com/en/authentication/connecting-to-github-with-ssh |

---

# 35. Final Project Summary

This project covers the practical Docker workflow:

```text
Install Docker
      |
      v
Understand Docker Architecture
      |
      v
Download Base Images
      |
      v
Create Dockerfile
      |
      v
Build Custom Image
      |
      v
Run Container
      |
      v
Configure Users and Permissions
      |
      v
Configure Networks and Volumes
      |
      v
Manage CPU, Memory and Storage
      |
      v
Monitor Container Resources
      |
      v
Perform Security Checks
      |
      v
Save Project with Git
      |
      v
Push Project to GitHub
```

**Project objective:** Build practical knowledge of Docker from the fundamentals through custom image creation, container operations, resource management, security checks, and GitHub-based project documentation.

---

**Author:** Faqdot  
**GitHub:** https://github.com/Faqdot  
**Repository:** https://github.com/Faqdot/Docker-Training

*This is a learning manual. Commands and sample outputs should be tested and verified in your own environment before being treated as actual results.*
