IMAGE_NAME=redis-cluster-emulator

CONTAINER_NAME=redis-cluster-emulator

HOST=127.0.0.1
PORT=6379
LIST=get,set
REQUESTS=30000
CLIENTS=1000
THREADS=2
BYTES=200
RATE=1000
PIPELINING=3

COMMAND=redis-benchmark -h $(HOST) -p $(PORT) -t $(LIST) -c $(CLIENTS) -n $(REQUESTS) --threads $(THREADS) -d $(BYTES) -r $(RATE) -k 1 -P $(PIPELINING) --cluster --enable-tracking

.PHONY: help
help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo "  build     Build docker image"
	@echo "  up        Run docker container"
	@echo "  check     Check cluster health"
	@echo "  down      Stop docker container"
	@echo "  destroy   Stop docker container and remove docker image"
	@echo "  benchmark Run redis-benchmark"
	@echo "  logs      Show logs"

.PHONY: build
build:
	docker build --no-cache -t $(IMAGE_NAME) .

.PHONY: up
up:
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):6379 -p 6380:6380 -p 6381:6381 -p 6382:6382 -p 6383:6383 -p 6384:6384 $(IMAGE_NAME)
	docker exec -it $(CONTAINER_NAME) redis-cli --cluster create 127.0.0.1:6379 127.0.0.1:6380 127.0.0.1:6381 127.0.0.1:6382 127.0.0.1:6383 127.0.0.1:6384 --cluster-replicas 1 --cluster-yes

.PHONY: check
check:
	docker exec $(CONTAINER_NAME) sh -c "redis-cli cluster info"

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
