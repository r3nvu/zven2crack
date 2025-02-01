use std::env;
use std::process::{Command, exit};
use std::path::Path;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() != 3 {
        eprintln!("Uso: cargo run <ruta_del_archivo_7z> <ruta_del_diccionario>");
        exit(1);
    }

    let archivo = &args[1];
    let diccionario = &args[2];

    let brute_force_dir = Path::new("zven2crack");

    if !brute_force_dir.exists() {
        eprintln!("El directorio '{}' no existe.", brute_force_dir.display());
        exit(1);
    }

    if let Err(e) = env::set_current_dir(&brute_force_dir) {
        eprintln!("No se pudo cambiar al directorio '{}': {}", brute_force_dir.display(), e);
        exit(1);
    }

    let status = Command::new("cargo")
        .args(&["run", "--release", "--", archivo, diccionario])
        .status()
        .expect("Error al ejecutar el módulo de fuerza bruta");

    if !status.success() {
        eprintln!("Error en la ejecución del módulo de fuerza bruta.");
        exit(1);
    }
}
