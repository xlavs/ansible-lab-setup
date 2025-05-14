#!/bin/sh

yum install -y tar gcc make openssl-devel bzip2-devel libffi-devel

cd /usr/src
curl -O https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
tar xzf Python-3.11.9.tgz
cd Python-3.11.9
./configure --enable-optimizations
make altinstall

python3.11 --version
