# CloudStudioSelfHostingDockerImage

A docker image for self-hosting the backend of Tencent Coding Cloud Studio

## Image detail

There are two images: [annangela/cloudstudio_selfhosting](https://hub.docker.com/repository/docker/annangela/cloudstudio_selfhosting) and [annangela/cloudstudio_selfhosting_php](https://hub.docker.com/repository/docker/annangela/cloudstudio_selfhosting_php), both images are based on Ubuntu 18.04 bionic latest image [which is the highest version that Cloud Studio supported](https://cloudstudio.net/docs/others/#:~:text=%E6%94%AF%E6%8C%81%2064%20%E4%BD%8D-,Ubuntu%2016.04/18.04,-%E5%92%8C%20CentOS%207).

| software in `annangela/cloudstudio_selfhosting` | version                                                                        |
| ----------------------------------------------: | ------------------------------------------------------------------------------ |
|                         openssh server & client | latest version available from Ubuntu 18.04 bionic apt repository               |
|                                            node | latest lts version using [nodejs version manager `n`](https://github.com/tj/n) |
|                                             npm | latest version (explicitly set environment variabl `N_PRESERVE_NPM` to `1`)    |

| software in `annangela/cloudstudio_selfhosting_php` | version                                                                                                                                             |
| --------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------------------------------------- |
|                             openssh server & client | latest version available from Ubuntu 18.04 bionic apt repository                                                                                    |
|                                                node | latest lts version using [nodejs version manager `n`](https://github.com/tj/n)                                                                      |
|                                                 npm | latest version (explicitly set environment variabl `N_PRESERVE_NPM` to `1`)                                                                         |
|                                             **php** | **latest current stable version with `php-curl` and `php-zip` extensions from [ppa:ondrej/php](https://launchpad.net/~ondrej/+archive/ubuntu/php)** |
|                                        **composer** | **latest version from [getcomposer.org](https://getcomposer.org/)**                                                                                 |

## docker compose detail

The [`docker-compose.yml` template file](https://github.com/AnnAngela/CloudStudioSelfHostingDockerImage/blob/master/docker-compose.yml) contains comment to introduce which folders and files are necessary to keep permanently, and which files should be generated before start up the container.

Here is a checklist for you to prepare:

0.  If you want to use php image, please replace `annangela/cloudstudio_selfhosting:latest` with `annangela/cloudstudio_selfhosting_php:latest`;
1.  Get the public key from Cloud Studio, and write it to `ssh/authorized_keys`;
2.  Generate a ed25519 key pair, and write it to `ssh/id_ed25519` & `ssh/id_ed25519.pub`;
3.  Generate a rsa key pair, and write it to `sshd/ssh_host_rsa_key` & `sshd/ssh_host_rsa_key.pub`;
4.  Generate a ecdsa key pair, and write it to `sshd/ssh_host_ecdsa_key` & `sshd/ssh_host_ecdsa_key.pub`;
5.  Generate a ed25519 key pair, and write it to `sshd/ssh_host_ed25519_key` & `sshd/ssh_host_ed25519_key.pub`;
6.  Download and check the [`sshd/sshd_config.d/cloudstudio.conf` file](https://github.com/AnnAngela/CloudStudioSelfHostingDockerImage/blob/master/sshd/sshd_config.d/cloudstudio.conf) and change it if necessary;
7.  Create the volumes:

```shell
docker volume create cloudstudio_resource
docker volume create cloudstudio_localShare_cloudstudio
docker volume create cloudstudio_localShare_codeServer
docker volume create cloudstudio_RemoteWorking
docker volume create cloudstudio_config
docker volume create cloudstudio_ssh
```
