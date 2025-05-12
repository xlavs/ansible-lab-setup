# About this

this is where You manually edited hosts file for reference. Now:

- ensure proper zabbix host is set in project variables
- run multipass script to generate current lab hosts: `scripts\multipass-export-hostslist.cmd`
- use `ansible-paybook ansible\update-local-etc-hosts.yaml` to update ansible-runner /etc/hosts