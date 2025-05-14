# Ansible testing lab setup with Multipass

## Requirements

- Windows 10/11 with Hyper-V enabled
- Ubuntu [Multipass](downloads/_sources.md) for Windows installed and available to user:

```
> multipass version
multipass   1.15.1+win
multipassd  1.15.1+win
```

- Run Powershell to Enable mounting local project folder using multipass

```powershell
multipass set local.privileged-mounts=true
```

## Create Ansible Runner

- Run Windows Administrative console and change to the project root, then create ansible runner
```
scripts\multipass-create-runner.cmd
```

If something goes wrong refer to the [Multipass Q&A](docs\multipass_qa.md) or Online documentation

On success You should be able to list the ansible-runner instance and get the vm shell

```
multipass list
```

```cmd
E:\lab\> multipass list
Name                    State             IPv4             Image
ansible-runner          Running           172.30.7.109     Ubuntu 24.04 LTS
```

```
multipass shell ansible-runner
```

```bash
E:\lab\> multipass shell ansible-runner
Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-59-generic x86_64)

# skipped shell logon messages

ubuntu@ansible-runner:~$
```

- Make sure project has been mounted on /workspace

```
cd /workspace && ls -l
```

```bash
ubuntu@ansible-runner:~$ cd /workspace && ls -l
total 12
-rw-rw-rw- 1 ubuntu ubuntu 2128 May 13 14:51 Makefile
-rw-rw-rw- 1 ubuntu ubuntu  631 May 14 00:33 README.md
drwxrwxrwx 1 ubuntu ubuntu    0 May 13 15:16 ansible
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 22:41 config
drwxrwxrwx 1 ubuntu ubuntu    0 May 13 23:18 docs
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 17:30 downloads
drwxrwxrwx 1 ubuntu ubuntu    0 May 13 23:13 scripts
-rw-rw-rw- 1 ubuntu ubuntu  238 May 11 14:57 shell.nix
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 01:37 tmp
```

- There is a Makefile to help with some of the maintenance tasks

```
make help
```

```
ubuntu@ansible-runner:/workspace$ make help
Available targets:
help                  Display this help message
secure-ansible-cfg    save provided ansible.cfg in the safe location
ansible-ping-local    Run ansible ping example
ansible-galaxy-list   List installed Ansible Galaxy Collections
ansible-galaxy-extra  Add extra Ansible Galaxy collections
list-downloads        List all downloads
download-zabbix-vhdx  Get zabbix server vhdx appliance
unzip-zabbix-vhdx     Extract downloaded Zabbix appliance VHDX disk image
generate-admin-ssh    Generate SSH keypair for admin user
set-user-password     Prompt and save default admin user password (hashed)
```

- Try running playbook that does local Ansible ping

```
ubuntu@ansible-runner:/workspace$ make ansible-ping-local
cd ansible && ansible-playbook ansible-ping-local.yaml

PLAY [ping local connection] ****************************************************************************************************************************

TASK [ping] *********************************************************************************************************************************************
ok: [localhost]

PLAY RECAP **********************************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

- Project depends on settings in `config` directory. Create and edit defaults.

```
cp /workspace/config/project-vars.env.yaml.example /workspace/config/project-vars.env.yaml
```

```
vim /workspace/config/project-vars.env.yaml
```

- Update Ansible defaults and inventory settings to match Your configuration in files:

- `ansible\inventory\hosts` example: `ansible\inventory\hosts.example`
- `ansible\inventory\group_vars\site_a.yaml`
- `ansible\inventory\group_vars\site_z.yaml`