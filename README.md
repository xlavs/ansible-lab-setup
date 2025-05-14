# Lab setup for testing Ansible

Create project folder and clone this repository there:

```cmd
mkdir ansible-lab
cd ansible-lab
git clone https://github.com/xlavs/ansible-lab-setup.git .
```

To run and test the following exercises You need to set up local lab environment. For Windows users, follow instructions in [docs\hyperv_lab_setup.md](docs\hyperv_lab_setup.md) to create lab environment on Windows10/11 using [Canonical Multipass](https://canonical.com/multipass/install) and Hyper-V virtualization.

Once Your target hosts are resolving, ansible ssh access works and all project-related settings in ./config/ and ./ansible/inventory are set, it should be possible to run `ansible\ansible-ping-lab.yaml`

All the exercise playbooks and related roles are in `./ansible` and `ansible/roles`

```bash
ubuntu@ansible-runner:/workspace/ansible$ ls -l | grep exercise
-rw-rw-rw- 1 ubuntu ubuntu   391 May 14 02:32 exercise-configure-chrony-service.yaml
-rw-rw-rw- 1 ubuntu ubuntu   747 May 14 02:32 exercise-configure-server-set.yaml
-rw-rw-rw- 1 ubuntu ubuntu   708 May 14 02:35 exercise-configure-zabbix-agent2.yaml
-rw-rw-rw- 1 ubuntu ubuntu   442 May 14 02:34 exercise-create-admin-user.yaml
```

```bash
ubuntu@ansible-runner:/workspace/ansible$ ls -l roles/
total 0
drwxrwxrwx 1 ubuntu ubuntu 0 May 12 22:02 configure_admin_user
drwxrwxrwx 1 ubuntu ubuntu 0 May 13 14:36 configure_ntp_chrony
drwxrwxrwx 1 ubuntu ubuntu 0 May 12 23:41 verify_ntp_config
```

---

### Github links
- [docs/hyperv_lab_setup.md](docs/hyperv_lab_setup.md)