#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "usage: $0 VERSION CHECKSUM" >&2
    exit 64
fi

VERSION=$1
CHECKSUM=$2
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_FILE="$(dirname "$SCRIPT_DIR")/Package.swift"

if ! printf '%s' "$VERSION" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "version must use the form 1.2.3" >&2
    exit 64
fi
if ! printf '%s' "$CHECKSUM" | grep -Eq '^[0-9a-f]{64}$'; then
    echo "checksum must be a lowercase SHA-256 digest" >&2
    exit 64
fi

perl -pi -e \
    "s/let binaryVersion = \"[^\"]+\"/let binaryVersion = \"$VERSION\"/" \
    "$PACKAGE_FILE"
perl -pi -e \
    "s/let binaryChecksum = \"[0-9a-f]+\"/let binaryChecksum = \"$CHECKSUM\"/" \
    "$PACKAGE_FILE"

