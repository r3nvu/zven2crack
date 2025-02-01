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

    printf "\e[31mEnvironment set up. \n\nTo use the tool, run ./zven2crack\e[0m"
else
    printf "\e[31mRust installation failed. Please try again.\e[0m"
fi

chmod +x zven2crack