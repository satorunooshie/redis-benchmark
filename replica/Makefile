IMAGE_NAME=redis-primary-replica

CONTAINER_NAME=redis-primary-replica

HOST=127.0.0.1
PORT=6379
LIST=get,set
REQUESTS=500000
CLIENTS=5000
THREADS=2
BYTES=200
RATE=150000
PIPELINING=3

COMMAND=redis-benchmark -h $(HOST) -p $(PORT) -t $(LIST) -c $(CLIENTS) -n $(REQUESTS) --threads $(THREADS) -d $(BYTES) -r $(RATE) -k 1 -P $(PIPELINING) --enable-tracking

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build     Build the Docker image"
	@echo "  up        Create and start the Docker container"
	@echo "  check     Check the replication status"
	@echo "  down      Stop and remove the Docker container"
	@echo "  destroy   Stop and remove the Docker container and image"
	@echo "  benchmark Run the benchmark"
	@echo "  logs      Show the logs of the Docker container"

.PHONY: build
build:
	docker build --no-cache -t $(IMAGE_NAME) .

.PHONY: up
up:
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):6379 -p 6380:6380 $(IMAGE_NAME)

.PHONY: check
check:
	docker exec -it $(CONTAINER_NAME) redis-cli -h localhost -p 6379 info replication
	docker exec -it $(CONTAINER_NAME) redis-cli -h localhost -p 6380 info replication

.PHONY: down
down:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

.PHONY: destroy
destroy: down
	-docker rmi $(IMAGE_NAME)

.PHONY: benchmark
benchmark:
	@mkdir -p logs
	@TIMESTAMP=$$(date "+%Y%m%d_%H%M%S"); \
	FILENAME="logs/benchmark_$$TIMESTAMP.log"; \
	echo $(COMMAND) >> $$FILENAME; \
	docker exec $(CONTAINER_NAME) sh -c "$(COMMAND)" >> $$FILENAME

.PHONY: logs
logs:
	docker logs -f $(CONTAINER_NAME)
