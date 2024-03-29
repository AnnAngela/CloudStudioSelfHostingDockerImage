FROM annangela/cloudstudio_selfhosting:latest AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive && \
    export DEBIAN_PRIORITY=critical && \
    apt update && apt install -y -o "Dpkg::Options::=--force-confold" --no-install-recommends gnupg unzip && \
    echo "deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list.d/ondrej-ubuntu-php.list && echo "deb-src https://ppa.launchpadcontent.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list.d/ondrej-ubuntu-php.list && \
    wget https://raw.githubusercontent.com/AnnAngela/CloudStudioSelfHostingDockerImage/master/Launchpad%20PPA%20for%20Ond%C5%99ej%20Sur%C3%BD.asc -O - -q | apt-key add - && \
    apt update && \
    apt install -y -o "Dpkg::Options::=--force-confold" --no-install-recommends php-cli php-curl php-zip && \
    apt autoremove -y --purge && \
    apt clean && \
    rm -rf /var/lib/apt /root/.launchpadlib && \
    wget https://getcomposer.org/installer -O - -q | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && echo "export COMPOSER_ALLOW_SUPERUSER=1" >> /root/.bashrc && \
    echo "done"'
