#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")
ARTIFACT_DIR="$PROJECT_DIR/Artifacts"
XCFRAMEWORK="$ARTIFACT_DIR/CFFF.xcframework"
ARCHIVE="$ARTIFACT_DIR/CFFF.xcframework.zip"

"$SCRIPT_DIR/build-xcframework.sh"
if [ -e "$ARCHIVE" ]; then
    rm -f "$ARCHIVE"
fi
ditto -c -k --sequesterRsrc --keepParent "$XCFRAMEWORK" "$ARCHIVE"

swift package compute-checksum "$ARCHIVE"

