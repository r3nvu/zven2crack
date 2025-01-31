use std::{
    fs::File,
    io::{BufRead, BufReader, Read},
    path::Path,
};

use anyhow::{Context, Result};
use sevenz_rust::SevenZReader; // Importación simplificada
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

    for pass in passwords {
        println!("Probando: {}", pass);

        for i in 0..zip.len() {
            if let Ok(Ok(mut file)) = zip.by_index_decrypt(i, pass.as_bytes()) {
                let mut buffer = Vec::new();
                if file.read_to_end(&mut buffer).is_ok() {
                    println!("Contraseña encontrada: {}", pass);
                    return Ok(());
                }
            }
        }
    }

    anyhow::bail!("Contraseña no encontrada");
}

fn atacar_7z(ruta: &str, passwords: &[String]) -> Result<()> {
    let path = Path::new(ruta);

    for pass in passwords {
        println!("Probando: {}", pass);

        // Usar `.into()` para convertir el `&str` a `Password`
        if SevenZReader::open(path, pass.as_str().into()).is_ok() {
            println!("Contraseña encontrada: {}", pass);
            return Ok(());
        }
    }

    anyhow::bail!("Contraseña no encontrada");
}