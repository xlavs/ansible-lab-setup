@echo off
REM -----------------------------------------------------------------------------
REM scripts\multipass-create-hosts.cmd Run Canonical Multipass to spin up
REM two hosts.
REM -----------------------------------------------------------------------------

REM Create Site-A
multipass launch --name site-a-host --cpus 2 --memory 4096M --disk 20G

REM Create Site-Z
multipass launch --name site-z-host --cpus 2 --memory 4096M --disk 20G
