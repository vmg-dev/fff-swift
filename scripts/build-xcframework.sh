#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")
VENDOR_DIR="$PROJECT_DIR/Vendor/fff"
TARGET=${RUST_TARGET:-aarch64-apple-darwin}
OUTPUT_DIR="$PROJECT_DIR/Artifacts"
XCFRAMEWORK="$OUTPUT_DIR/CFFF.xcframework"
TEMP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/fff-swift.XXXXXX")

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT HUP INT TERM

rustup target add "$TARGET"
MACOSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET:-14.0} \
    cargo build \
        --manifest-path "$VENDOR_DIR/Cargo.toml" \
        --package fff-c \
        --release \
        --locked \
        --target "$TARGET"

LIBRARY="$VENDOR_DIR/target/$TARGET/release/libfff_c.a"
HEADERS="$TEMP_DIR/Headers"
mkdir -p "$HEADERS" "$OUTPUT_DIR"
cp "$VENDOR_DIR/crates/fff-c/include/fff.h" "$HEADERS/fff.h"
cp "$PROJECT_DIR/Support/CFFF/module.modulemap" "$HEADERS/module.modulemap"

if [ -e "$XCFRAMEWORK" ]; then
    rm -rf "$XCFRAMEWORK"
fi

xcodebuild -create-xcframework \
    -library "$LIBRARY" \
    -headers "$HEADERS" \
    -output "$XCFRAMEWORK"

echo "$XCFRAMEWORK"

