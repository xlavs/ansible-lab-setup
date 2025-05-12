@echo off
REM ---------------------------------------------------------------------
REM scripts\multipass-export-hostslist.cmd - Export multipass host data
REM to ansible\inventory\multipath-hosts.yaml
REM
REM Use this to update ansible inventory hosts file manually
REM ---------------------------------------------------------------------

multipass list --format yaml > ansible\inventory\multipass-hosts.yaml