# ----------------------------------------------------------------------------
# Makefile for running tasks via WSL
# ----------------------------------------------------------------------------

# The "help" target uses grep/awk magic to parse lines that have the format:
#   target: ## Description of the target
# and outputs them as a nicely formatted help menu.
.PHONY: help

help: ## Display this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

deploy-config: ## Deploy ansible.cfg to ~/.ansible.cfg
	cp ../config/ansible.cfg ~/.ansible.cfg
	ls -la ~/.ansible.cfg
