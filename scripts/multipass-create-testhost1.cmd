@echo off
REM -----------------------------------------------------------------------------
REM scripts\multipass-create-testhost1.cmd Run Canonical Multipass to spin up
REM testing host using cloud-init template with Ansible public key.
REM -----------------------------------------------------------------------------

REM Create test-host1
multipass launch 24.04 --name test-host1 --cpus 2 --memory 2G --disk 20G --cloud-init config\multipass-host.yaml
