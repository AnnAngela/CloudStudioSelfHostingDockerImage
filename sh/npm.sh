#!/usr/bin/env bash
npm config set registry http://mirrors.tencentyun.com/npm/
echo "export N_PRESERVE_NPM=1" | tee -a /root/.bashrc

npm install npm n -g
rm -rf /root/.npm
mkdir -p /root/.npm