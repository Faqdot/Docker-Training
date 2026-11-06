# 🐉 Secure Kali Linux Docker Lab

A step-by-step guide to creating a Kali Linux Docker container with separate `kali` and `root` users, password-protected sudo access, and a customized terminal environment.

## 📌 Project Overview

This project creates a customized Kali Linux environment inside Docker.

### Features

- Kali Linux Rolling image
- Separate regular user (`kali`)
- Root administrator account
- Password-protected sudo authentication
- Custom hostname: `kali-training`
- Custom working directory: `/home/dev/project`
- Docker container management
- Bash terminal customization
- Easy container access using aliases

## 🛠️ 1. Prerequisites

Make sure Docker is installed on your Ubuntu/WSL system.

Check Docker version:

```bash
docker --version
```

Check Docker service:

```bash
sudo service docker status
```

Create a Docker shortcut (optional):

```bash
echo "alias d='docker'" >> ~/.bashrc
source ~/.bashrc
```

Test:

```bash
d ps
```

## 📥 2. Download Kali Linux Image

Pull the official Kali Linux Rolling image:

```bash
d pull kalilinux/kali-rolling
```

Verify:

```bash
d images
```

## 📁 3. Create Project Directory

Create a directory for your Docker configuration:

```bash
mkdir kali-lab
cd kali-lab
```

Create a Dockerfile:

```bash
nano Dockerfile
```

## 🐳 4. Create Dockerfile

Paste the following configuration:

```dockerfile
FROM kalilinux/kali-rolling

# Update packages and install basic tools
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
    && rm -rf /var/lib/apt/lists/*

# Create regular user
RUN useradd -m -s /bin/bash kali

# Add kali user to sudo group
RUN usermod -aG sudo kali

# Create project directory
RUN mkdir -p /home/dev/project && \
    chown -R kali:kali /home/dev

# Configure environment
ENV HOME=/home/kali
ENV PS1='kali@kali-training:\w\$ '

# Set working directory
WORKDIR /home/dev/project

# Run container as regular user
USER kali

CMD ["/bin/bash"]
```

**Note:** Passwords are not hardcoded into the Dockerfile. They will be configured interactively after the container is created.

Save the file:

- Press `Ctrl + O`
- Press `Enter`
- Press `Ctrl + X`

## 🔨 5. Build Custom Docker Image

Build the image:

```bash
d build -t secure-kali .
```

Check the image:

```bash
d images
```

## 🚀 6. Create and Start Container

Create the Kali container:

```bash
d run -dit \
  --name kali-container \
  --hostname kali-training \
  --workdir /home/dev/project \
  secure-kali
```

Verify:

```bash
d ps
```

## 🔑 7. Configure Root and Kali Passwords

Enter the container as root:

```bash
d exec -u root -it kali-container /bin/bash
```

Set the root password:

```bash
passwd root
```

Set the regular user password:

```bash
passwd kali
```

Enter a strong password twice for each account.

Verify users:

```bash
id root
id kali
```

## 🔐 8. Configure Sudo Authentication

The regular user should require a password when executing administrative commands.

Create a sudoers configuration:

```bash
visudo -f /etc/sudoers.d/kali
```

Add:

```text
kali ALL=(ALL:ALL) ALL
```

Save and exit.

Set correct permissions:

```bash
chmod 440 /etc/sudoers.d/kali
```

Validate the configuration:

```bash
visudo -c
```

Make sure there is no conflicting `NOPASSWD` rule for the kali user.

## 👤 9. Access Container as Regular User

Exit the root shell:

```bash
exit
```

Enter as the regular user:

```bash
d exec -it \
  --user kali \
  --workdir /home/dev/project \
  kali-container \
  /bin/bash
```

Check your identity:

```bash
whoami
id
pwd
echo $HOME
```

Expected information:

```text
kali
/home/dev/project
/home/kali
```

## 🔒 10. Test Sudo Password Authentication

Run:

```bash
sudo whoami
```

You should see:

```text
[sudo] password for kali:
```

Enter the kali user's password.

Expected output:

```text
root
```

## 👑 11. Switch Between Regular User and Root

Switch to root:

```bash
su -
```

Enter the root password.

Check:

```bash
whoami
```

Expected:

```text
root
```

Return to the regular user:

```bash
exit
```

**Important:** Docker administrators can enter a container as root using `docker exec -u root`. Container passwords do not restrict administrators who control the Docker daemon.

## ⚙️ 12. Create Kali Terminal Shortcut

On the Ubuntu/WSL host, create a script:

```bash
sudo nano /usr/local/bin/kali
```

Add:

```bash
#!/bin/bash

exec docker exec -it \
  --user kali \
  --workdir /home/dev/project \
  --env HOME=/home/kali \
  --env 'PS1=kali@kali-training:\w\$ ' \
  kali-container \
  /bin/bash --noprofile --norc
```

Save the file.

Make it executable:

```bash
sudo chmod +x /usr/local/bin/kali
```

Now enter the container using:

```bash
kali
```

**Note:** This shortcut selects the `kali` user directly through Docker. It does not ask for the Linux account password. Use `sudo` or `su` inside the container when authentication is required.

## 🧰 13. Useful Docker Commands

| Command | Description |
|---|---|
| `d ps` | Show running containers |
| `d ps -a` | Show all containers |
| `d images` | Show Docker images |
| `d start kali-container` | Start container |
| `d stop kali-container` | Stop container |
| `d restart kali-container` | Restart container |
| `d exec -it kali-container bash` | Enter container |
| `d logs kali-container` | View container logs |
| `d inspect kali-container` | Inspect container |
| `d rm kali-container` | Remove stopped container |
| `d rmi IMAGE_ID` | Remove image |

## 🔍 14. Verify Your Environment

Inside the Kali container, run:

```bash
whoami
hostname
pwd
id
sudo whoami
```

Expected results:

```text
kali
kali-training
/home/dev/project
uid=... (kali) ...
[sudo] password for kali:
root
```

## 🛠️ 15. Troubleshooting

### Problem 1: Unable to find user kali

Error:

```text
unable to find user kali:
no matching entries in passwd file
```

Solution:

```bash
d exec -u root -it kali-container bash
useradd -m -s /bin/bash kali
usermod -aG sudo kali
passwd kali
```

### Problem 2: Sudo password is not working

Check sudo permissions:

```bash
groups kali
```

Check sudoers configuration:

```bash
visudo -c
```

Reset the password as root:

```bash
passwd kali
```

### Problem 3: Container is not running

Check:

```bash
d ps -a
```

Start:

```bash
d start kali-container
```

### Problem 4: Image cannot be deleted

Remove the container first:

```bash
d stop kali-container
d rm kali-container
```

Then remove the image:

```bash
d rmi IMAGE_ID
```

## 🔄 16. Rebuild the Environment

If you modify your Dockerfile, rebuild the image:

```bash
d build -t secure-kali .
```

To recreate the container:

```bash
d rm -f kali-container
```

```bash
d run -dit \
  --name kali-container \
  --hostname kali-training \
  --workdir /home/dev/project \
  secure-kali
```

**Important:** Recreating the container resets its writable-layer changes, including passwords configured after creation. Configure the passwords again. Use Docker volumes if you need persistent project data.

## 📚 17. Important Docker Concepts

| Concept | Meaning |
|---|---|
| Image | Template used to create containers |
| Container | Running instance of an image |
| Dockerfile | Instructions for building an image |
| `docker build` | Build an image |
| `docker run` | Create and start a container |
| `docker exec` | Execute commands inside a running container |
| `docker rm` | Remove a container |
| `docker rmi` | Remove an image |
| `-it` | Interactive terminal |
| `-d` | Background execution |
| `-u` | Select container user |
| `--hostname` | Set container hostname |
| `--workdir` | Set container working directory |

## 🎯 Final Result

Your Kali Docker environment will have:

- Regular account: `kali`
- Administrator account: `root`
- Separate passwords for both users
- Password-protected sudo
- Custom hostname: `kali-training`
- Working directory: `/home/dev/project`
- Convenient terminal access using `kali`

---

## ⚠️ Security Notes

- Use strong, unique passwords.
- Never store passwords in a public GitHub repository.
- Do not enable passwordless sudo unless you understand the security implications.
- Do not expose SSH or other container services publicly without appropriate security controls.
- Remember that Docker daemon access effectively grants root-level control over containers.

## 👨‍💻 Author

**Kali Linux Docker Lab**

A personal Linux and DevOps learning environment.
