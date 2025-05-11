
- Zabbix Server vhdx

Site: https://www.zabbix.com/download_appliance
Download: https://cdn.zabbix.com/zabbix/appliances/stable/7.2/7.2.6/zabbix_appliance-7.2.6-vhdx.zip

Note - Ansible access to zabbix-node requires python3. Log in to root and refer to the sample script
to compile python for zabbix appliance: [get-python-for-zabbix-appliance.sh](../scripts/get-python-for-zabbix-appliance.sh)

- Canonical Multipass (vm provisioning tool for Ubuntu and Windows Hyper-V)
Site: https://canonical.com/multipass/install
Download: https://canonical.com/multipass/download/windows

Note - privileged mounts have to be enabled:
```powershell
multipass set local.privileged-mounts=true
```

## Optional Downloads

- Visual Studio Code

Site: https://code.visualstudio.com/download
Direct download link: https://code.visualstudio.com/sha/download?build=stable&os=win32-arm64