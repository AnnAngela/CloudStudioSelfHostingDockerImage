FROM ubuntu:bionic AS slave
RUN apt update && apt install -y lsb-release && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ondrej-ubuntu-php.list
FROM ubuntu:bionic AS master
COPY --from=slave /etc/apt/sources.list.d/ondrej-ubuntu-php.list /etc/apt/sources.list.d/ondrej-ubuntu-php.list
COPY "sh" "/tmp/sh"
RUN ["chmod", "-R", "+x", "/tmp/sh"]
RUN /tmp/sh/apt.sh && /tmp/sh/nodejs.sh
RUN /tmp/sh/npm.sh && rm -r /tmp/sh
CMD eval `ssh-agent -s` && /usr/bin/ssh-add && /usr/sbin/sshd -D -e -E /var/log/sshd/sshd.log
