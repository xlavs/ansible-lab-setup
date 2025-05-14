# Netplan Configuration Cheat-Sheet (Ubuntu 18.04+)

Netplan config files are stored in:
```

/etc/netplan/\*.yaml

````

## Basic Static IP Configuration

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        search: [corp.local]
        addresses:
          - 192.168.1.53
          - 192.168.1.54
```

---


> This works only if the renderer is `networkd` and `systemd-timesyncd` is in use.

---

## DHCP with Static Overrides (e.g. DNS or NTP)

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
      optional: true
```

---

## Apply Netplan

After editing YAML files:

```bash
sudo netplan apply
```

For debugging:

```bash
sudo netplan try      # Safe test, 120s rollback if error
sudo netplan generate # Generates backend config
```

---

## Tips & Gotchas

* `networkd` is ideal for servers/headless systems; `NetworkManager` is used on desktops.
* `optional: true` can help if interface doesn't come up at boot time.
* Use `ip a` and `systemd-resolve --status` to inspect results.

