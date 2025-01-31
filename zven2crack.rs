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

    let project_dir = Path::new("zven2crack");
    if !project_dir.exists() {
        eprintln!("El directorio '{}' no existe.", project_dir.display());
        exit(1);
    }

    env::set_current_dir(project_dir).expect("Error al cambiar el directorio");

    let output = Command::new("cargo")
        .arg("run")
        .arg(archivo)
        .arg(diccionario)
        .output()
        .expect("Error al ejecutar cargo run");

    if !output.status.success() {
        eprintln!("Error en la ejecución: {}", String::from_utf8_lossy(&output.stderr));
        exit(1);
    }

    println!("{}", String::from_utf8_lossy(&output.stdout));
}