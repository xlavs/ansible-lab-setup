@echo off
REM ------------------------------------------------------------------------------
REM scripts\multipass-create-runner.cmd - Create 'ansible-runner' via 
REM Multipass with project folder mounted to /workplace in the `ansible-runner`.
REM ------------------------------------------------------------------------------
setlocal enabledelayedexpansion

REM Load project variables
call config\project-vars.env.cmd

REM Set default VM name and mount paths
set VM_NAME=ansible-runner
set LAB_WORKSPACE=/workspace

REM Launch VM if not running
echo [INFO] Ensuring VM '!VM_NAME!' is running...
multipass info !VM_NAME! --format json >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo [INFO] Launching '!VM_NAME!' with Ubuntu 24.04...
  multipass launch 24.04 ^
  --name !VM_NAME! ^
  --cpus 2 --memory 2G --disk 10G ^
  --cloud-init config/multipass-ansible-runner.yaml
)

REM Mount workspace (safe to re-run)
echo [INFO] Mounting project folder...
multipass mount "%WORKSPACE_WIN%" !VM_NAME!:!LAB_WORKSPACE! 2>nul

REM Show VM status
multipass info !VM_NAME!

