
#!/usr/bin/env bash

# Simple launcher for zven2crack: uses the release binary if available,
# otherwise falls back to `cargo run --release`.

set -euo pipefail
usage() {
    cat <<EOF
Usage:
    $0 install            Install Rust (if needed), build release and install /usr/local/bin/zven2crack
    $0 <archive.7z> <dictionary>   Run the tool against an archive using a dictionary
EOF
    exit 1
}

install_rust_and_build() {
    echo "Setting up Rust toolchain (non-interactive)..."
    # Install rustup non-interactively
    if ! command -v rustup >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    else
        echo "rustup already installed"
    fi

    echo "Building release binary..."
    cargo build --release

    # Choose built binary name
    BIN_SRC=""
    if [ -f "target/release/zven2crack" ]; then
        BIN_SRC="target/release/zven2crack"
    elif [ -f "target/release/zven2crack-main" ]; then
        BIN_SRC="target/release/zven2crack-main"
    fi

    if [ -z "$BIN_SRC" ]; then
        echo "Release binary not found after build. Aborting."
        exit 1
    fi

    echo "Installing to /usr/local/bin/zven2crack (may require sudo)..."
    sudo cp "$BIN_SRC" /usr/local/bin/zven2crack
    sudo chmod +x /usr/local/bin/zven2crack
    echo "Installed /usr/local/bin/zven2crack"
}


if [ "$#" -eq 0 ]; then
    usage
fi

if [ "$1" = "install" ] || [ "$1" = "setup" ]; then
    install_rust_and_build
    exit 0
fi

# Normal run: expect two args
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

