FROM annangela/cloudstudio_selfhosting:latest AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive && \
    export DEBIAN_PRIORITY=critical && \
    echo "deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu bionic main" >> /etc/apt/source.list && echo "deb-src https://ppa.launchpadcontent.net/ondrej/php/ubuntu bionic main" >> /etc/apt/source.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    apt update && \
    apt install -y -o "Dpkg::Options::=--force-confold" --no-install-recommends php-cli libapache2-mod-php8.1- php-apcu-bc- php7.4-common- php7.3-common- php7.2-common- php7.1-common- php7.0-common- php5.6-common- && \
    apt autoremove -y --purge && \
    apt clean && \
    rm -rf /var/lib/apt /root/.launchpadlib && \
    wget https://getcomposer.org/installer -O - -q | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && echo "export COMPOSER_ALLOW_SUPERUSER=1" >> /root/.bashrc && \
    echo "done"'
