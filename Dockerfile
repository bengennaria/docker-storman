FROM phusion/baseimage:0.11

# set maintainer label
LABEL maintainer="fish2"

# Set correct environment variables
ARG password
ARG DEBIAN_FRONTEND="noninteractive"
ENV JAVA_HOME=/usr/StorMan/jre
CMD ["/sbin/my_init"]

COPY /StorMan /etc/my_init.d/StorMan

# Install Update and Install Packages
RUN apt update && apt remove --purge -y openssh-client openssh-server openssh-sftp-server && apt upgrade -y -o Dpkg::Options::="--force-confold" && apt install -y net-tools unzip && \
rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh && \
sh -c "echo root:${password:-docker} |chpasswd" && \
curl -o /tmp/msm_linux.tgz http://download.adaptec.com/raid/storage_manager/msm_linux_x64_v3_03_23668.tgz && \
tar -xf /tmp/msm_linux.tgz -C /tmp && \
dpkg -i /tmp/manager/StorMan-3.03-23668_amd64.deb && \
apt autoremove -y && apt clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
chmod +x /etc/my_init.d/StorMan

# Ports, Entry Points and Volumes
EXPOSE 8443
HEALTHCHECK --interval=1m --timeout=5s --retries=3 \
  CMD curl -skSL -D - https://localhost:8443 -o /dev/null || exit 1
