#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

cd blockscout-rs-neti/golem-base-tools/
cargo build

cd ../../golembase-op-geth
patch -N <../chain-scripts/golembase-op-geth-enable-txpool-api.patch || true
patch -N <../chain-scripts/golembase-op-geth-rpclorer-external-port.patch || true
patch -N <../chain-scripts/golembase-op-geth-all-interfaces.patch || true
docker compose up -d --build

cd cmd/golembase
go build -o golembase

echo
echo "Running. Visit http://localhost:9000/ to verify."
echo "RPC endpoint available at http://localhost:8545 and ws://localhost:8545"
