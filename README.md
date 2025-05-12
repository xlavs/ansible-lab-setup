# Lab setup for testing Ansible

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

- Make sure [config\project-vars.env.cmd](config\project-vars.env.cmd) is created. [Example](config/project-vars.env.cmd.example) is provided

- Run Windows Administrative console and change to the project home then create ansible runner:
```
scripts\multipass-create-runner.cmd
```

- Make sure there are no errors. To fix any errors You can delete and recreate the ansible-runner:

```
> multipass delete ansible-runner
> multipass purge
> scripts\multipass-create-runner.cmd
```

This implementation uses Nix packages to build Ansible environment. Once VM is created:
```
> multipass list
Name                    State             IPv4             Image
ansible-runner          Running           172.30.7.109     Ubuntu 24.04 LTS

> multipass shell ansible-runner
Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-59-generic x86_64)


Install nix:
curl -L https://nixos.org/nix/install | sh

Then:
cd /workspace
nix-shell

ubuntu@ansible-runner:~$
```

- Make sure project has been mounted on /workspace

```
ubuntu@ansible-runner:~$ ls -l /workspace/
total 16
-rw-rw-rw- 1 ubuntu ubuntu 1317 May 11 22:02 Makefile
-rw-rw-rw- 1 ubuntu ubuntu  617 May 12 02:44 README.md
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 01:19 ansible
-rwxrwxrwx 1 ubuntu ubuntu  719 May 12 02:19 ansible-runner.cmd
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 01:45 config
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 02:21 docs
drwxrwxrwx 1 ubuntu ubuntu    0 May 11 17:38 downloads
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 02:21 scripts
-rw-rw-rw- 1 ubuntu ubuntu  238 May 11 14:57 shell.nix
drwxrwxrwx 1 ubuntu ubuntu    0 May 12 01:37 tmp
```

- You can examine shell.nix to see which pachages will be installed

```
ubuntu@ansible-runner:/workspace$ cat /workspace/shell.nix
# config/nix/shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    coreutils gnugrep gawk findutils jq file tree wget unzip zip
    iputils dig
    vim-full emacs-nox git
    ansible
  ];
}
```

- Follow instructions from /etc/motd to install nix package manager
- Enable environment settings or exit/enter ansible-runner shell again
- Enter nix-shell:

`$ nix-shell /workspace/shell.nix` or `cd /workspace && nix-shell`

- Secure ansible.cfg
```
cp /workspace/ansible/ansible.cfg-example /home/ubuntu/.ansible.cfg
chmod go= /home/ubuntu/.ansible.cfg
```

- Try local simple playbook (local ping)

```
cd /workspace/ansible
[nix-shell:/workspace]$ cd /workspace/ansible/

[nix-shell:/workspace/ansible]$ ansible-playbook playbooks/ansible-ping-local.yaml
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [ping local connection] ******************************************************************************************************

TASK [ping] ***********************************************************************************************************************
ok: [localhost]

PLAY RECAP ************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

- Back in the Windows Administrative shell use multipass to install, site-a-host and site-z-host

[scripts\multipass-create-hosts.cmd](scripts\multipass-create-hosts.cmd)

```
> multipass list
Name                    State             IPv4             Image
ansible-runner          Running           172.30.7.109     Ubuntu 24.04 LTS
site-a                  Running           172.30.14.143    Ubuntu 24.04 LTS
site-z                  Running           172.30.14.102    Ubuntu 24.04 LTS
```

- export vm settings to ansible\inventory\multipass-hosts.yaml

```cmd
> scripts\multipass-export-hostslist.cmd
```

- Use [ansible\inventory\multipass-hosts.yaml](ansible\inventory\multipass-hosts.yaml) as reference to edit hosts files:

| file name                                          | example                                                            | description                         |
| -------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------- |
| [ansible\files\etc\hosts](ansible\files\etc\hosts) | [ansible\files\etc\hosts.example](ansible\files\etc\hosts.example) | append to ansible-runner:/etc/hosts |
| [ansible\inventory\hosts](ansible\inventory\hosts) | [ansible\inventory\hosts.example](ansible\inventory\hosts.example) | ansible inventory file (ini format) |

- Generate ssh keys on ansible-runner with `ssh-keygen`

- use `multipass shell site-a-host` and `multipass shell site-a-host` and apped `/home/ubuntu/.ssh/authorized_keys` to include public ssh key from `ansible-runner:/home/ubuntu/.ssh/id_ed25519.pub`

- use ssh-copy-id to add ssh keys for `root@zabbix-node` access

- (optional) log in to `root@zabbix-node` and follow instructions in [scripts\get-python-for-zabbix-appliance.sh](scripts\get-python-for-zabbix-appliance.sh) to install python on zabbix-node.

That should enable ansible access to all current lab hosts:

```
[nix-shell:/workspace/ansible]$ ansible-playbook playbooks/ansible-ping-lab.yaml 
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [zabbix-node,site-a-host,site-z-host] ***************************************************************************************************************************************************
TASK [ping] **********************************************************************************************************************************************************************************
ok: [zabbix-node]
ok: [site-a-host]
ok: [site-z-host]

PLAY RECAP ***********************************************************************************************************************************************************************************
site-a-host                : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
site-z-host                : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
zabbix-node                : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

- Once ready, install LXD on site-a-host and site-z-host

```
ansible-playbook playbooks/configure-lxd-subsystem.yaml
```

- Once complete You should be able to log on and see lxc container running:

```
[nix-shell:/workspace]$ ssh ubuntu@site-a-host

ubuntu@site-a:~$ sudo lxc list
+-------------+---------+----------------------+-----------------------------------------------+-----------+-----------+
|    NAME     |  STATE  |         IPV4         |                     IPV6                      |   TYPE    | SNAPSHOTS |
+-------------+---------+----------------------+-----------------------------------------------+-----------+-----------+
| mycontainer | RUNNING | 10.201.67.214 (eth0) | fd42:f9bd:d9dc:1e1e:216:3eff:feb8:9c1d (eth0) | CONTAINER | 0         |
+-------------+---------+----------------------+-----------------------------------------------+-----------+-----------+
```

- You can enter `mycontainer` as well

```
ubuntu@site-a:~$ sudo bash
root@site-a:/home/ubuntu# lxc shell mycontainer
root@mycontainer:~# 
```