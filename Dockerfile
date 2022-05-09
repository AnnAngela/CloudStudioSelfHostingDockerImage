FROM ubuntu:bionic AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive ; \
    export DEBIAN_PRIORITY=critical ; \
    mkdir -p /var/run/sshd /var/log/sshd /root/.ssh /etc/ssh/sshd_config.d ; \
    rm -f /etc/update-motd.d/60-unminimize ; \
    sed -i -E "s/http:/https:/g" /etc/apt/sources.list ; \
    apt update ; \
    apt install -y -o "Dpkg::Options::=--force-confold" software-properties-common; \
    add-apt-repository ppa:ondrej/php; \
    apt update ; \
    apt install -y -o "Dpkg::Options::=--force-confold" curl wget ca-certificates nano openssh-server openssh-client git php-apcu php-bcmath php-bz2 php-curl php-fpm php-gd php-igbinary php-imagick php-intl php-json php-mbstring php-mysql php-pear php-pgsql php-redis php-ssh2 php-xml php-zip php libapache2-mod-php8.1- php-apcu-bc- php7.4-common- php7.3-common- php7.2-common- php7.1-common- php7.0-common- php5.6-common- ; \
    apt remove -y software-properties-common ; \
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
