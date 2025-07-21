
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

update:
	git submodule update --remote --merge --recursive

chain-run:
	bash ./golem-base-dbchains/start-dbchain.sh

chain-stop:
	docker compose down -f ./golem-base-dbchains/golembase-op-geth/docker-compose.yml

chain-logs:
	docker compose logs -f ./golem-base-dbchains/golembase-op-geth --tail=100

chain-clear:
	docker compose down -f ./golem-base-dbchains/golembase-op-geth -v 

.PHONY: build run logs stop clear init update chain-run chain-stop chain-logs chain-clear


