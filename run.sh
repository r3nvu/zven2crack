#!/bin/bash

echo "Actualizando el sistema..."
sudo apt-get update

echo "Instalando dependencias necesarias..."
sudo apt-get install -y build-essential curl

echo "Instalando Rust y Cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Configurando las variables de entorno..."
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

if ! grep -q "$CARGO_HOME/bin" "$HOME/.bashrc"; then
    echo "export CARGO_HOME=$HOME/.cargo" >> "$HOME/.bashrc"
    echo "export RUSTUP_HOME=$HOME/.rustup" >> "$HOME/.bashrc"
    echo "export PATH=\$CARGO_HOME/bin:\$PATH" >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
fi

cd zven2crack