use std::env;
use std::process::Command;
use std::path::Path;

pub fn verificar_args() -> Option<(String, String)> {
    let args: Vec<String> = env::args().collect();

    if args.len() != 3 {
        eprintln!("Uso: cargo run <ruta_del_archivo_7z> <ruta_del_diccionario>");
        return None;
    }

    let archivo = args[1].clone();
    let diccionario = args[2].clone();

    Some((archivo, diccionario))
}

pub fn verificar_directorio(brute_force_dir: &Path) -> bool {
    if !brute_force_dir.exists() {
        eprintln!("El directorio '{}' no existe.", brute_force_dir.display());
        return false;
    }

    true
}

pub fn cambiar_directorio(brute_force_dir: &Path) -> bool {
    if let Err(e) = env::set_current_dir(brute_force_dir) {
        eprintln!("No se pudo cambiar al directorio '{}': {}", brute_force_dir.display(), e);
        return false;
    }

    true
}

pub fn ejecutar_fuerza_bruta(archivo: &str, diccionario: &str) -> bool {
    let status = Command::new("cargo")
        .args(&["run", "--release", "--", archivo, diccionario])
        .status()
        .expect("Error al ejecutar el módulo de fuerza bruta");

    if !status.success() {
        eprintln!("Error en la ejecución del módulo de fuerza bruta.");
        return false;
    }

    true
}