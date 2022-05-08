# CloudStudioSelfHostingDockerImage

A docker image for self-hosting the backend of Tencent Coding Cloud Studio

## Image detail

This image is based on Ubuntu 18.04 bionic latest image [which is the highest version that Cloud Studio supported](https://cloudstudio.net/docs/others/#:~:text=%E6%94%AF%E6%8C%81%2064%20%E4%BD%8D-,Ubuntu%2016.04/18.04,-%E5%92%8C%20CentOS%207).

|                software | version                                                                                                |
| ----------------------: | ------------------------------------------------------------------------------------------------------ |
| openssh server & client | latest version available from Ubuntu 18.04 bionic APT repository                                       |
|                    node | latest lts version using [nodejs version manager `n`](https://github.com/tj/n)                         |
|                     npm | latest version (explicitly set environment variabl `N_PRESERVE_NPM` to `1`  in `sh/npm.sh`)            |
|                     php | latest current stable version from [ppa:ondrej/php](https://launchpad.net/~ondrej/+archive/ubuntu/php) |

## docker compose detail

The `docker-compose.yml` file contains comment to introduce which folders and files are necessary to keep permanently, and which files should be generated before start up the container.

Here is a checklist for you to prepare:

1. Get the public key from Cloud Studio, and write it to `ssh/authorized_keys`;
2. Generate a ed25519 key pair, and write it to `ssh/id_ed25519` & `ssh/id_ed25519.pub`;
3. Generate a rsa key pair, and write it to `sshd/ssh_host_rsa_key` & `sshd/ssh_host_rsa_key.pub`;
4. Generate a ecdsa key pair, and write it to `sshd/ssh_host_ecdsa_key` & `sshd/ssh_host_ecdsa_key.pub`;
5. Generate a ed25519 key pair, and write it to `sshd/ssh_host_ed25519_key` & `sshd/ssh_host_ed25519_key.pub`;
6. Check the `sshd/sshd_config.d/cloudstudio.conf` and change it if necessary;
7. Create the volumes:
```shell
docker volume create cloudstudio_resource
docker volume create cloudstudio_localShare_cloudstudio
docker volume create cloudstudio_localShare_codeServer
docker volume create cloudstudio_RemoteWorking
docker volume create cloudstudio_config
docker volume create cloudstudio_ssh
```