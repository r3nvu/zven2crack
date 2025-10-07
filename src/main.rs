use std::path::Path;
use std::process::exit;
mod bruteforce;
mod worker;

fn main() {
    let brute_force_dir = Path::new("zven2crack");
    let (archivo, diccionario) = match bruteforce::verificar_args() {
        Some(args) => args,
        None => exit(1),
    };

    if !bruteforce::verificar_directorio(&brute_force_dir) {
        exit(1);
    }

    if !bruteforce::cambiar_directorio(&brute_force_dir) {
        exit(1);
    }

    if !bruteforce::ejecutar_fuerza_bruta(&archivo, &diccionario) {
        exit(1);
    }
}
