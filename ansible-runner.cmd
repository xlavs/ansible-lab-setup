@echo off
rem
rem enter ansible-runner shell using multipass
rem ansible runner has to be created and visible among multipass hosts:
rem
rem   cmd> multipass list
rem   Name                    State             IPv4             Image
rem   ansible-runner          Running           172.30.7.109     Ubuntu 24.04 LTS
rem   site-a-host             Running           172.30.14.143    Ubuntu 24.04 LTS
rem                                             10.201.67.1
rem   site-z-host             Running           172.30.14.102    Ubuntu 24.04 LTS
rem                                             10.201.67.1

setlocal

multipass exec ansible-runner -- bash --rcfile /home/ubuntu/.profile -c nix-shell

endlocal