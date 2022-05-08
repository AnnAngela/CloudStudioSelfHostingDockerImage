FROM --platform=linux/amd64 ubuntu:bionic
COPY "sh" "/tmp/sh"
RUN ["chmod", "-R", "+x", "/tmp/sh"]
RUN ["/tmp/sh/apt.sh"]
RUN ["/tmp/sh/nodejs.sh"]
RUN ["/tmp/sh/npm.sh"]
RUN ["rm", "-r", "/tmp/sh"]
CMD eval `ssh-agent -s` ; /usr/bin/ssh-add ; /usr/sbin/sshd -D -e -E /var/log/sshd/sshd.log