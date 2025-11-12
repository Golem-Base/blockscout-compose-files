#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."
cd blockscout-rs-neti/golem-base-tools/crates/gen-test-data

sender=$(cast rpc eth_accounts | jq -r '.[0]')
cast_send="cast send --gas-price 1gwei --priority-gas-price 1gwei --gas-limit 10000000 --unlocked --from $sender 0x00000000000000000000000000000061726B6976"

function storage_send() {
  calldata=$(cargo run -- "$@")
  $cast_send $calldata
}

function create() {
  storage_send create:"$1":1000 | grep logs | head -1 | awk '{ print $2; }' | jq -r '.[0].topics[1]'
}

deleteme=$(create "data that will be deleted")
updateme1=$(create "data that will be updated")
updateme2=$(create "data that will be updated with annotations")
extendme=$(create "data that will be extended")
changeowner=$(create "data that will change ownership")

calldata=$(cargo run -- \
  create:"data that will expire immediately":1:expire=true \
  create:"data with annotations":1000:key=val:key2=123 \
  update:$updateme1:"updated data":2000 \
  update:$updateme2:"updated data with annotations":2000:key=updated:updated=1 \
  delete:$deleteme \
  extend:$extendme:2001 \
  change-owner:$changeowner:0x000000000000000000000000000000000000dead
)

$cast_send $calldata >/dev/null
storage_send delete:0xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd >/dev/null || true # we want to see a failed transaction onchain and make sure we expire data created in previous tx
