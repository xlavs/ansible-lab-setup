@echo off
REM -----------------------------------------------------------------------------
REM scripts\multipass-create-hosts.cmd Run Canonical Multipass to spin up
REM two hosts.
REM -----------------------------------------------------------------------------

REM Create Site-A
multipass launch 24.04 --name test-host1 --cpus 2 --memory 2G --disk 20G --cloud-init config\multipass-host.yaml
