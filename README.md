# Golem Base L3 development stack runner

This is a collection of docker compose and scripts to run the Golem Base L3 development stack.

## Requirements

- Docker
- Go (chain only)
- Rust (chain only)
- Foundry (chain only)

## Usage

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Available components are defined in `.env` file under `COMPOSE_PROFILES` variable:

- `backend` - blockscout backend
- `frontend` - blockscout frontend
- `services` - blockscout rs services (e.g. golem-base-indexer)

***Before changing components in `.env`, you need to stop the containers.***

Init submodules:

```bash
# git submodule update --init --recursive
make sub-init
```

Run chain:

```bash
# bash ./golem-base-dbchains/start-dbchain.sh
make chain-run
```

Run stack:

```bash
# docker compose up -d
make run
```
