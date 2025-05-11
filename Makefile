# ----------------------------------------------------------------------------
# Makefile for running tasks from 
# ----------------------------------------------------------------------------

# The "help" target uses grep/awk magic to parse lines that have the format:
#   target: ## Description of the target
# and outputs them as a nicely formatted help menu.
.PHONY: help

help: ## Display this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

ansible-ping-local: ## Run ansible ping example
	cd ansible && ansible-playbook playbooks/ansible-ping-local.yaml

ansible-galaxy-list: ## List installed Ansible Galaxy Collections
	ansible-galaxy collection list

ansible-galaxy-extra: ## Add extra Ansible Galaxy collections
	ansible-galaxy collection install zabbix.zabbix
	
list-downloads: ## List all downloads
	ls -ltr downloads/

download-zabbix-vhdx: ## Get zabbix server vhdx appliance
	cd downloads && wget https://cdn.zabbix.com/zabbix/appliances/stable/7.2/7.2.6/zabbix_appliance-7.2.6-vhdx.zip

unzip-zabbix-vhdx: ## Extract downloaded Zabbix appliance VHDX to Hyper-V disk path
	unzip -n downloads/zabbix_appliance-7.2.6-vhdx.zip -d hyperv_disks