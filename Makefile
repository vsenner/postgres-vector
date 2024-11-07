build: ## Build the docker image.
	docker buildx build --platform linux/amd64,linux/arm64 -t senner/postgres-vector-postgres:latest . --push

start: ## Start the docker container.
	docker compose -f docker-compose.yml up

stop: ## Start the docker container.
	docker compose -f docker-compose.yml stop
