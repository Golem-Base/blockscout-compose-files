# Golem Base blockscout components
build:
	docker compose build 
run:
	docker compose up -d --build
logs:
	docker compose logs -f
stop:
	docker compose down
clear:
	docker compose down -v

# Golem Base dbchain
chain-run:
	bash ./chain-scripts/start-dbchain.sh
chain-stop:
	docker compose -f ./golembase-op-geth/docker-compose.yml down
chain-logs:
	docker compose -f ./golembase-op-geth/docker-compose.yml logs -f --tail=100
chain-clear:
	docker compose -f ./golembase-op-geth/docker-compose.yml down -v
chain-generate:
	bash ./chain-scripts/generate-data.sh

# Submodule management
sub-deinit:
	git submodule deinit --all --force
sub-init:
	git submodule update --init --recursive
sub-update:
	git submodule update --remote --merge --recursive --force
sub-clear:
	git submodule foreach --recursive 'git reset --hard HEAD && git clean -fdx'


.PHONY: build run logs stop clear chain-run chain-stop chain-logs chain-clear chain-generate sub-deinit sub-init sub-update sub-clear



