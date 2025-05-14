# Running Zabbix appliance on HyperV

Site: https://www.zabbix.com/download_appliance
Download: https://cdn.zabbix.com/zabbix/appliances/stable/7.2/7.2.6/zabbix_appliance-7.2.6-vhdx.zip

Installation - extract archive to Your Hyper-V/virtual_disks then create vm in Hyper-V manager to use downloaded vhdx image. 
Name it zabbix-node. Follow official Zabbix documentation.

## (Optionally) To enable Ansible access to the local Zabbix appliance

- use ssh-copy-id to add ssh keys for `root@zabbix-node` access

Note - Ansible access to zabbix-node requires python3. Log in to root@zabbix-node and refer to the sample script
to compile python for zabbix appliance: [get-python-for-zabbix-appliance.sh](../scripts/get-python-for-zabbix-appliance.sh)

Ansible `hosts` configuration example to connect to `zabbix-node`:

```
[zabbix]
zabbix-node ansible_user=root ansible_python_interpreter=/usr/local/bin/python3.11
```