
build:
	docker compose build 
	
run:
	docker compose up -d

logs:
	docker compose logs -f

stop:
	docker compose down

clear:
	rm -rf ./data

init:
	git submodule update --init --recursive

sub-update:
	git submodule update --remote --merge --recursive --force

sub-clear:
	git submodule foreach --recursive 'git reset --hard HEAD && git clean -fdx'


chain-run:
	bash ./golem-base-dbchains/start-dbchain.sh

chain-stop:
	docker compose -f ./golem-base-dbchains/golembase-op-geth/docker-compose.yml down

chain-logs:
	docker compose -f ./golem-base-dbchains/golembase-op-geth/docker-compose.yml logs -f --tail=100

chain-clear:
	docker compose -f ./golem-base-dbchains/golembase-op-geth/docker-compose.yml down -v

chain-generate:
	bash ./golem-base-dbchains/generate-data.sh

.PHONY: build run logs stop clear init update chain-run chain-stop chain-logs chain-clear chain-generate sub-update sub-clear


