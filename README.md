# Golem Base L3 development stack runner

This is a collection of docker compose and scripts to run the Golem Base L3 development stack.

## Requirements

- Docker
- Go
- Rust
- Foundry

## Usage 

Init submodules:

```bash
# git submodule update --init --recursive
make init
```

Run chain:
```bash
make chain-run
```

Run indexer, frontend, and rs services:
```bash
make run
```
