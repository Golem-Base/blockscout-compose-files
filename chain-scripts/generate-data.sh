#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

pwd="$(pwd)"
cd "$pwd"/golembase-op-geth/cmd/golembase

deleteme=$(./golembase entity create --data "data that will be deleted" --btl 1000 | awk '{ print $NF }')
updateme1=$(./golembase entity create --data "data that will be updated" --btl 1000 | awk '{ print $NF }')
updateme2=$(./golembase entity create --data "data that will be updated with annotations" --btl 1000 | awk '{ print $NF }')
extendme=$(./golembase entity create --data "data that will be extended" --btl 1000 | awk '{ print $NF }')

linux_path=~/.config/golembase/private.key
mac_path=~/Library/Application\ Support/golembase/private.key

private_key_path=""
if [ -f "$linux_path" ]; then
  private_key_path="$linux_path"
elif [ -f "$mac_path" ]; then
  private_key_path="$mac_path"
else
  echo "Error: Private key not found."
  exit 1
fi
sender=$(cat "$private_key_path" | od -An -v -tx1 | tr -d ' \n')

cd "$pwd"/blockscout-rs-neti/golem-base-tools/crates/gen-test-data
calldata=$(cargo run -- \
  create:"data that will expire immediately":1 \
  create:"data with annotations":1000:key=val:key2=123 \
  update:$updateme1:"updated data":2000 \
  update:$updateme2:"updated data with annotations":2000:key=updated:updated=1 \
  delete:$deleteme \
  extend:$extendme:2001)

cast send --private-key $sender 0x0000000000000000000000000000000060138453 $calldata

cd "$pwd"/golembase-op-geth/cmd/golembase
./golembase entity delete --key 0xdeadbeaf &>/dev/null || true # we want to see a failed transaction onchain and make sure we expire data created in previous tx
