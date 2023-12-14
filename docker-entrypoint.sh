#!/usr/bin/env bash

set -euo pipefail

ARGS=()

LISTEN_ADDR="${LISTEN_ADDR:-"0.0.0.0:8080"}"
echo "Setting listen address: $LISTEN_ADDR"
ARGS+=("-listen-address" "$LISTEN_ADDR")

RESOLVERS="${RESOLVERS:-"8.8.8.8:53,1.1.1.1:53"}"
echo "Using resolvers: $RESOLVERS"
ARGS+=("-resolvers" "$RESOLVERS")

TIMEOUT="${TIMEOUT:-"10s"}"
echo "Using DNS timeout: $TIMEOUT"
ARGS+=("-timeout" "$TIMEOUT")

CONFIG="${CONFIG:-$(pwd)/config}"
echo "Using config file: $CONFIG"
ARGS+=("-config" "$CONFIG")

set -x
exec prometheus-dnssec-exporter "${ARGS[@]}"
