#!/bin/bash

echo -n "Inserte la ruta del archivo .7z: "
read archivo_7z

if [ ! -f "$archivo_7z" ]; then
    echo "El archivo especificado no existe."
    exit 1
fi

echo -n "Inserte la ruta del diccionario: "
read diccionario

if [ ! -f "$diccionario" ]; then
    echo "El diccionario especificado no existe."
    exit 1
fi

cargo run -- "$archivo_7z" "$diccionario"
