#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

mkdir -p /var/run/sshd
mkdir -p /var/log/sshd
mkdir -p /root/.ssh
mkdir -p /etc/ssh/sshd_config.d
mkdir -p /root/.coding-cloudstudio
rm -f /etc/update-motd.d/60-unminimize

apt update
apt install -y -o "Dpkg::Options::=--force-confold" software-properties-common curl wget ca-certificates nano openssh-server openssh-client git

add-apt-repository ppa:ondrej/php
apt update
apt install -y -o "Dpkg::Options::=--force-confold" php-apcu php-bcmath php-bz2 php-curl php-fpm php-gd php-igbinary php-imagick php-intl php-json php-mbstring php-mysql php-pear php-pgsql php-redis php-ssh2 php-xml php-zip php libapache2-mod-php8.1- php-apcu-bc- php7.4-common- php7.3-common- php7.2-common- php7.1-common- php7.0-common- php5.6-common-

apt autoremove -y
apt clean
rm -rf /var/lib/apt/lists/*
rm -rf /root/.launchpadlib
