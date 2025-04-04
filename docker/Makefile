.DEFAULT_GOAL := help


DOCKER_COMPOSE_DEV = docker compose -f compose.dev.yml

.PHONY: help
help: ## Display this help message
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: build-dev
build-dev: ## Builds test docker images
	@$(DOCKER_COMPOSE_DEV) build


.PHONY: bring-up
bring-up: ## Raises the app
	@$(DOCKER_COMPOSE_DEV) up -d --force-recreate

.PHONY: bring-down
bring-down: ## Stops the app
	@$(DOCKER_COMPOSE_DEV) down --remove-orphans
