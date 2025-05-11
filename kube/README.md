# Getting Ansible environment up using Minikube

## Bootstrap Minikube following directions:

https://minikube.sigs.k8s.io/docs/start/

## Download and run the installer for the latest release.
Or if using PowerShell, use this command:

```ps
New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
```

## Add the minikube.exe binary to your PATH.
Make sure to run PowerShell as Administrator.

```
$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
if ($oldPath.Split(';') -inotcontains 'C:\minikube'){
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine)
}
```

## Enabling Hyper-V
https://minikube.sigs.k8s.io/docs/drivers/hyperv/

Open a PowerShell console as Administrator, and run the following command:

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

### Usage

Commands below has to be run from an administrative console:

```
minikube config set driver hyperv

minikube start
```

To run minikube with a project folder mounted as /workspace there is a script `scripts\kube-start.cmd`


### Use from vsc terminal

To get minikube kubectl work like generic kubectl, You should set variables:

```
set KUBECONFIG=%USERPROFILE%\.kube\config
kubectl get pods -A
```

### Building docker images to run in minikube

Look inside the in project folder scripts:

```
build-ansible-ee.cmd
build-nix-ee.cmd
```

Note: alpine based ee (build-ansible-ee.cmd) currently did not build for some reason. Nix based ee (exectution environment) works. Glory to the Nix!

### Pod lifecycle management:

```
kubectl delete pod ansible-runner-nix --ignore-not-found
kubectl apply -f kube/ansible-runner-nix.yaml
kubectl exec -it ansible-runner-nix -- bash
```