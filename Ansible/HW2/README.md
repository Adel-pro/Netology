# Clickhouse and Vector Playbook

This is an ansible playbook to install Clickhouse and Vector. 

## Constraints
  - You need 2 virtual machines which have public IP-address.
  - To install Clickhouse you need a machine with OS Centos/Fedora.
  - To install Vector you need a machine with OS Ubuntu.

## Versions
This playbook install 22.3.3.44 version for Clickhouse and 0.34.2 version for Vector. You can change versions in vars.yml files which are located in group_vars directory.  

## Install
```
# Deploy with ansible playbook  
ansible-playbook -i inventory/prod.yml site.yml
```
