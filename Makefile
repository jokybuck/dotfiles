DOTPATH      := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES   := $(wildcard .??*) bin
EXCLUSIONS   := .DS_Store .git .gitignore .github
DOTFILES     := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTFILES_DIR := $(PWD)

.DEFAULT_GOAL := htlp

all:

.PHONY: list
list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), ls -dl $(val);)

.PHONY: deploy
deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@bash $(DOTFILES_DIR)/etc/deploy

.PHONY: install
install: ## Install dependencies and setup dot files
	$(MAKE) update
	@echo '==> Start to install dependencies'
	@echo ''
	@bash $(DOTFILES_DIR)/etc/install
	$(MAKE) deploy

.PHONY: update
update: ## Fetch changes for this repo
	@git pull origin main

.PHONY: clean
clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

