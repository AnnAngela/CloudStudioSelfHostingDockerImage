FROM annangela/cloudstudio_selfhosting:latest AS main
RUN /bin/bash -c '\
    export DEBIAN_FRONTEND=noninteractive ; \
    export DEBIAN_PRIORITY=critical ; \
    apt update ; \
    apt install -y -o "Dpkg::Options::=--force-confold" software-properties-common; \
    add-apt-repository -u ppa:ondrej/php; \
    apt install -y -o "Dpkg::Options::=--force-confold" php-bcmath php-bz2 php-curl php-intl php-json php-mbstring php-pear php-xml php-zip php-cli php libapache2-mod-php8.1- php-apcu-bc- php7.4-common- php7.3-common- php7.2-common- php7.1-common- php7.0-common- php5.6-common- ; \
    apt purge -y software-properties-common ; \
    apt autoremove -y ; \
    apt clean ; \
'
