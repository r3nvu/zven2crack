#!/usr/bin/env bash
echo "This file was merged into zven2crack.sh. Use ./zven2crack.sh install instead."
exit 0
#!/bin/bash
printf "\n"
printf "\e[31m                        ____                     _    \n"
printf "\e[31m   ______   _____ _ __ |___ \ ___ _ __ __ _  ___| | __\n"
printf "\e[33m  |_  /\ \ / / _ \ '_ \  __) / __| '__/ _\` |/ __| |/ /\n"
printf "\e[33m   / /  \ V /  __/ | | |/ __/ (__| | | (_| | (__|   < \n"
printf "\e[31m  /___|  \_/ \___|_| |_|_____\___|_|  \__,_|\___|_|\_\ \n\n"
printf "\e[97mby @rubenvmu \n\e[0m"

printf "\e[97mInstalling Rust and Cargo...\n\e[0m"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
if [ -d "$HOME/.cargo" ] && [ -d "$HOME/.rustup" ]; then
    printf "\e[31mConfiguring environment variables...\n\e[0m"
    export CARGO_HOME="$HOME/.cargo"
    export RUSTUP_HOME="$HOME/.rustup"

    if ! grep -q "$CARGO_HOME/bin" "$HOME/.bashrc"; then
        echo "export CARGO_HOME=$HOME/.cargo" >> "$HOME/.bashrc"
        echo "export RUSTUP_HOME=$HOME/.rustup" >> "$HOME/.bashrc"
        echo "export PATH=\$CARGO_HOME/bin:\$PATH" >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
    fi

    source $HOME/.cargo/env
        printf "\e[31mEnvironment set up. Building release binary...\n\e[0m"

        # Build release binary
        cargo build --release

        # Create a small wrapper script 'zven2crack' that executes the installed binary
        ZWRAPPER="/usr/local/bin/zven2crack"
        echo "Creating wrapper at $ZWRAPPER (requires sudo)..."
        cat > zven2crack.wrapper.tmp <<'EOF'
#!/bin/sh
# Wrapper for zven2crack
exec /usr/local/bin/zven2crack-bin "$@"
EOF

        # Install the main binary and wrapper
        # Choose existing built binary name
        BIN_SRC=""
        if [ -f "target/release/zven2crack" ]; then
            BIN_SRC="target/release/zven2crack"
        elif [ -f "target/release/zven2crack-main" ]; then
            BIN_SRC="target/release/zven2crack-main"
        fi

        if [ -n "$BIN_SRC" ]; then
            echo "Installing binaries to /usr/local/bin (may require sudo)"
            sudo cp "$BIN_SRC" /usr/local/bin/zven2crack-bin
            sudo mv zven2crack.wrapper.tmp $ZWRAPPER
            sudo chmod +x $ZWRAPPER /usr/local/bin/zven2crack-bin
            echo "Installed 'zven2crack' as: zven2crack"
        else
            echo "Release binary not found; skipping system install. You can run the tool via ./zven2crack.sh or cargo run --release --"
            rm -f zven2crack.wrapper.tmp
        fi

        printf "\e[31mInstallation complete. You can run: zven2crack <args>\n\e[0m"
else
    printf "\e[31mRust installation failed. Please try again.\e[0m"
fi

chmod +x zven2crack