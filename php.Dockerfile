FROM annangela/cloudstudio_selfhosting:latest AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive && \
    export DEBIAN_PRIORITY=critical && \
    apt update && \
    apt install -y -o "Dpkg::Options::=--force-confold" --no-install-recommends software-properties-common&& \
    add-apt-repository -u ppa:ondrej/php&& \
    apt install -y -o "Dpkg::Options::=--force-confold" --no-install-recommends php-cli libapache2-mod-php8.1- php-apcu-bc- php7.4-common- php7.3-common- php7.2-common- php7.1-common- php7.0-common- php5.6-common- && \
    apt purge -y software-properties-common && \
    apt autoremove -y --purge && \
    apt clean --purge && \
    rm -rf /var/lib/apt /root/.launchpadlib && \
    echo "done"'
