# Running local test-hosts with Hyper-V

- You can automate provisioning of local test hosts by updating [config\multipass-host.yaml](config\multipass-host.yaml) to install public key of ansible-runner user (ubuntu).

(On ansible-runner)
```bash
ssh-keygen && cat ~/.ssh/id_ed25519.pub
```

Copy the public key and update multipass-host.yaml

```
# config/multipass-host.yaml

# Enable Ansible ssh access using ansible user public key. Update with Your actual key.
runcmd:
  - echo ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFy/uG6GOFYpjXFslP3TjM0CmxL1dbM0DPmJRwkvPKIF ubuntu@ansible-runner >> /home/ubuntu/.ssh/authorized_keys
```

Then it should be possible to provision all necessary following provided example cmd script `scripts\multipass-create-testhost1.cmd`

```
@echo off
REM -----------------------------------------------------------------------------
REM scripts\multipass-create-testhost1.cmd Run Canonical Multipass to spin up
REM testing host using cloud-init template with Ansible public key.
REM -----------------------------------------------------------------------------

REM Create test-host1
multipass launch 24.04 --name test-host1 --cpus 2 --memory 2G --disk 20G --cloud-init config\multipass-host.yaml
```

Once done, You might be able to see all multipass-managed hosts:

```
multipass list
```

```cmd
E:\lab\> multipass list
Name                    State             IPv4             Image
ansible-runner          Running           172.30.7.109     Ubuntu 24.04 LTS
hostname1               Running           172.30.14.143    Ubuntu 24.04 LTS
hostname2               Running           172.30.14.102    Ubuntu 24.04 LTS
```

## Automating `ansible-runner` host management

In Windows run:

```cmd
scripts\multipass-export-hostslist.cmd
```

In ansible-runner run:

```
cd /workspace/ansible && ansible-playbook update-local-etc-hosts.yaml
```

That should enable ansible access the managed test hosts

```bash
$ ansible-playbook playbooks/ansible-ping-lab.yaml 

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
