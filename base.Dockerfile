FROM ubuntu:bionic AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive ; \
    export DEBIAN_PRIORITY=critical ; \
    mkdir -p /var/run/sshd /var/log/sshd /root/.ssh /etc/ssh/sshd_config.d ; \
    rm -f /etc/update-motd.d/60-unminimize ; \
    apt update ; \
    apt install -y -o "Dpkg::Options::=--force-confold" curl wget ca-certificates nano openssh-server openssh-client git ; \
    apt autoremove -y ; \
    apt clean ; \
    rm -rf /var/lib/apt/lists/* /root/.launchpadlib ; \
    wget https://raw.githubusercontent.com/tj/n/master/bin/n -O /tmp/n ; \
    bash /tmp/n lts ; \
    rm /tmp/n ; \
    echo "export N_PRESERVE_NPM=1" | tee -a /root/.bashrc ; \
    /usr/local/bin/npm install npm n -g ; \
    rm -rf /root/.npm ; \
    mkdir -p /root/.npm ; \
'
CMD eval `ssh-agent -s` && /usr/bin/ssh-add && /usr/sbin/sshd -D -e -E /var/log/sshd/sshd.log