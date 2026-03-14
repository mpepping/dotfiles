# vim:ft=make:
OS_NAME := $(shell uname -s | tr A-Z a-z)

# Auto-detect container runtime
CONTAINER_RUNTIME := $(shell which container 2>/dev/null || which docker 2>/dev/null || which podman 2>/dev/null || echo "")

ifeq ($(CONTAINER_RUNTIME),)
$(error No docker, podman or container found in PATH)
endif


.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

shellcheck: ## Run shellcheck on all files in cfg/
	@shellcheck cfg/.bashrc cfg/.bashrc.d/* cfg/.fzf.bash

test: ## Start an interactive shell for testing
	@bash tests/test.sh

runtime: ## Show detected container runtime and OS
	@echo "Using container runtime: $(CONTAINER_RUNTIME) on $(OS_NAME)"

