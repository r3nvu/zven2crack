
#!/usr/bin/env bash

# Simple launcher for zven2crack: uses the release binary if available,
# otherwise falls back to `cargo run --release`.

set -euo pipefail

usage() {
    echo "Usage: $0 <archive.7z> <dictionary>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    usage
fi

ARCHIVE="$1"
DICT="$2"

if [ ! -f "$ARCHIVE" ]; then
    echo "Archive not found: $ARCHIVE"
    exit 1
fi

if [ ! -f "$DICT" ]; then
    echo "Dictionary not found: $DICT"
    exit 1
fi

RELEASE_BIN="target/release/zven2crack-main"

if [ -x "$RELEASE_BIN" ]; then
    exec "$RELEASE_BIN" "$ARCHIVE" "$DICT"
else
    echo "Release binary not found; running via cargo (this will require Rust/Cargo)."
    exec cargo run --release -- "$ARCHIVE" "$DICT"
fi

