# NixOS for WSL configuration bootstrapping

Please, note the limitations of wsl - Windows isolates wsl environment and the rest of HyperV
When to work with lab environemnet under HyperV refer to running minikube environment and related tools:

[kube/README.md](../kube/README.md)

NixOS sources: https://github.com/nix-community/NixOS-WSL/releases/latest

https://github.com/nix-community/NixOS-WSL/releases/download/2405.5.4/nixos-wsl.tar.gz

https://nix-community.github.io/NixOS-WSL/install.html

NixOS image install:

- replace e: with drive of Your system to place wsl
- ensure e:\wsl exists
- download nixos-wsl.tar.gz to your download folder
- import nixos as wsl environment to work as dev environment/control node

```
wsl --import NixOS E:\WSL\control-node-nixos\ nixos-wsl.tar.gz --version 2
```

To get a NixOS shell:
```
wsl -d NixOS
```

- my personal prefered configuration setup:

```
# make sure configuration.nix and and modules are copied to nixos /etc/nixos
cd nixos/nixos-sysconfig
cp -R etc/nixos /etc/nixos
```

Rebuild the config:
```
sudo nix-channel --update
```