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

echo "Creando el proyecto Rust..."
cargo new 7z-to-Crack

cd 7z-to-Crack

echo "Creando directorios adicionales..."
mkdir -p dictionaries src logs temp

echo "Creando .gitignore..."
echo "target/" > .gitignore
echo "*.log" >> .gitignore
echo "*.gz" >> .gitignore
echo "*.7z" >> .gitignore
echo "temp/" >> .gitignore

echo "Creando README.md..."
cat > README.md <<EOL
# Proyecto 7z-to-Crack

Este proyecto tiene como objetivo la automatización del crackeo de archivos 7z utilizando un diccionario de contraseñas. Los archivos de diccionario se encuentran en el directorio 'dictionaries'.

## Estructura del proyecto

- `dictionaries/`: Contiene los diccionarios de contraseñas.
- `src/`: Código fuente de la aplicación.
- `logs/`: Archivos de registro para depuración.
- `temp/`: Archivos temporales generados durante la ejecución.
- `README.md`: Documentación del proyecto.
EOL

echo "Configurando Cargo.toml..."
cat > Cargo.toml <<EOL
[package]
name = "zven2crack"
version = "0.1.0"
edition = "2025"

[dependencies]
zip = "0.6.6"
sevenz-rust = "0.1.1"
anyhow = "1.0.80"
EOL

echo "Creando archivo src/main.rs..."
mkdir -p src
cat > src/main.rs <<EOL
fn main() {
    println!("Iniciando el proyecto 7z-to-Crack...");
    // Implementar lógica para crackear archivos 7z
}
EOL

echo "El proyecto Rust ha sido creado con éxito."
echo "Estructura del proyecto:"
tree

source $HOME/.cargo/env
