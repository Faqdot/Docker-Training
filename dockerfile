FROM kalilinux/kali-rolling

#install basic packages
RUN apt update && apt install -y sudo bash nano vim curl wget git && rm -rf var/lib/apt/lists/*


#Create kali user
RUN useradd -m -s /bin/bash kali
#create project directory
RUN mkdir -p /home/devsec/project && chown -R kali:kali /home/devsec

#Set terminal prompt 
ENV HOME=/home/kali
ENV PS1='kali@kali-training:\w\$'

#Switch to kali user
USER kali
CMD ["/bin/bash"]

