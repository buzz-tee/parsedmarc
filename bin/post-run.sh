#!/bin/sh

SCRIPT="$(readlink -f "$0")"
BASEDIR="$(readlink -f "$(dirname ${SCRIPT})/..")"

CACHEDIR="${BASEDIR}/cache"

echo "Removing mail files from cache"

rm -rf "${CACHEDIR}"/*
