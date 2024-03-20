#!/bin/bash

# copy project from local vm, connect to remote vm and run docker compose
# ip=62.84.122.242
# scp -r /home/test/hw2/shvirtd-example-python-main/ test@$ip:/home/test/
# ssh test@$ip -i /home/test/id_rsa <<EOF
# cd /home/test/shvirtd-example-python-main/
# docker compose up -d
# EOF

# copy project from repository and run docker compose
sudo apt update
sudo apt install git
cd /opt
git clone git@github.com:Adel-pro/shvirtd-example-python.git
cd /opt/shvirtd-example-python/
docker compose up -d
