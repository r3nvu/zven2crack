use std::{
    fs::File,
    io::{BufRead, BufReader, Read},
    path::Path,
};

use anyhow::{Context, Result};
use sevenz_rust::SevenZReader; 
use zip::ZipArchive;

fn main() -> Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        anyhow::bail!("Uso: {} <archivo> <diccionario>", args[0]);
    }

    let (archivo, diccionario) = (&args[1], &args[2]);
    let passwords = cargar_diccionario(diccionario)?;

    if archivo.ends_with(".zip") {
        atacar_zip(archivo, &passwords)
    } else if archivo.ends_with(".7z") {
        atacar_7z(archivo, &passwords)
    } else {
        anyhow::bail!("Formato no soportado");
    }
}

fn cargar_diccionario(ruta: &str) -> Result<Vec<String>> {
    let archivo = File::open(ruta).context("Error al abrir diccionario")?;
    let lineas = BufReader::new(archivo)
        .lines()
        .filter_map(|l| l.ok())
        .map(|l| l.trim().to_string())
        .collect();
    Ok(lineas)
}

fn atacar_zip(ruta: &str, passwords: &[String]) -> Result<()> {
    let archivo = File::open(ruta).context("Error al abrir ZIP")?;
    let mut zip = ZipArchive::new(BufReader::new(archivo)).context("ZIP inválido")?;

    let mut counter = 0; // Contador de contraseñas probadas

    for pass in passwords {
        counter += 1; // Incrementar el contador
        // Ya no se imprime la contraseña, pero se incrementa el contador
        if counter % 10 == 0 {
            println!("Probadas {} contraseñas", counter); // Mostrar cada 10 contraseñas
        }

        for i in 0..zip.len() {
            if let Ok(Ok(mut file)) = zip.by_index_decrypt(i, pass.as_bytes()) {
                let mut buffer = Vec::new();
                if file.read_to_end(&mut buffer).is_ok() {
                    println!("Contraseña encontrada después de probar {} contraseñas", counter);
                    return Ok(());
                }
            }
        }
    }

    anyhow::bail!("Contraseña no encontrada");
}

fn atacar_7z(ruta: &str, passwords: &[String]) -> Result<()> {
    let path = Path::new(ruta);

    let mut counter = 0;

    for pass in passwords {
        counter += 1;

        let result = SevenZReader::open(path, pass.as_str().into());
        if result.is_ok() {
            println!("Contraseña encontrada después de probar {} contraseñas", counter);
            return Ok(());
        }
    }

    println!("Contraseña no encontrada después de probar {} contraseñas", counter);
    anyhow::bail!("Contraseña no encontrada");
}