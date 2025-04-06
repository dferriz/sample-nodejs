.DEFAULT_GOAL := help


DOCKER_COMPOSE_APP = docker compose -f compose.app.yml
DOCKER_COMPOSE_SCALABLE = docker compose -f compose.scalable.yml

.PHONY: help
help: ## Display this help message
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: build-app
build-app: ## Builds dev images
	@$(DOCKER_COMPOSE_APP) build


.PHONY: bring-up-app
bring-up-app:
	@$(DOCKER_COMPOSE_APP) up -d --force-recreate

.PHONY: bring-down-app
bring-down-app:
	@$(DOCKER_COMPOSE_APP) down --remove-orphans

.PHONY: app-logs
app-logs:
	@$(DOCKER_COMPOSE_APP) logs -f


.PHONY: build-scalable
build-scalable:
	@$(DOCKER_COMPOSE_SCALABLE) build base_app


.PHONY: bring-up-scalable
bring-up-scalable:
	@$(DOCKER_COMPOSE_SCALABLE) up -d --force-recreate app_a app_b

.PHONY: bring-down-scalable
bring-down-scalable:
	@$(DOCKER_COMPOSE_SCALABLE) down --remove-orphans app_a app_b

.PHONY: scalable-logs
scalable-logs:
	@$(DOCKER_COMPOSE_SCALABLE) logs -f warm_stage app_a app_b
