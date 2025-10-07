use std::env;
use std::fs::File;
use std::io::{BufWriter, Write};
use std::path::Path;
use std::process::Command;
use crate::worker;

pub fn verify_directory(brute_force_dir: &Path) -> bool {
    if !brute_force_dir.exists() {
        eprintln!("Directory '{}' does not exist.", brute_force_dir.display());
        return false;
    }

    true
}

pub fn change_directory(brute_force_dir: &Path) -> bool {
    if let Err(e) = env::set_current_dir(brute_force_dir) {
        eprintln!(
            "Failed to change to directory '{}': {}",
            brute_force_dir.display(),
            e
        );
        return false;
    }

    true
}

// Simple generator that writes all combinations of the charset between min_len and max_len.
// WARNING: Number of lines grows exponentially.
pub fn generate_dictionary(out_path: &Path, min_len: usize, max_len: usize, charset: &str) -> bool {
    let file = match File::create(out_path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!(
                "Failed to create output file '{}': {}",
                out_path.display(),
                e
            );
            return false;
        }
    };

    let mut writer = BufWriter::new(file);
    let chars: Vec<char> = charset.chars().collect();

    for len in min_len..=max_len {
        let total = chars.len().pow(len as u32);
        if total == 0 {
            continue;
        }

        let mut indices = vec![0usize; len];

        for _ in 0..total {
            let mut s = String::with_capacity(len);
            for &i in &indices {
                s.push(chars[i]);
            }
            if writeln!(writer, "{}", s).is_err() {
                eprintln!("Error writing to dictionary");
                return false;
            }

            for pos in (0..len).rev() {
                if indices[pos] + 1 < chars.len() {
                    indices[pos] += 1;
                    break;
                } else {
                    indices[pos] = 0;
                }
            }
        }
    }

    true
}

pub fn run_bruteforce(archive: &str, dictionary: &Path) -> bool {
    let dic_str = match dictionary.to_str() {
        Some(s) => s,
        None => {
            eprintln!("Invalid dictionary path");
            return false;
        }
    };

    // Prefer calling the embedded worker directly for a single-binary experience.
    match worker::run_worker(archive, dic_str) {
        Ok(()) => true,
        Err(e) => {
            eprintln!("Local worker failed ({}). Falling back to external run.", e);
            let status = if Command::new("zven2crack").arg("--help").output().is_ok() {
                Command::new("zven2crack")
                    .args([archive, dic_str])
                    .status()
                    .expect("Error executing installed 'zven2crack' binary")
            } else {
                Command::new("cargo")
                    .args(["run", "--release", "--", archive, dic_str])
                    .status()
                    .expect("Error executing brute force module via cargo")
            };

            if !status.success() {
                eprintln!("Brute force module execution failed.");
                return false;
            }

            true
        }
    }
}

pub fn verificar_args() -> Option<(String, String)> {
    let mut it = std::env::args().skip(1);
    let archivo = match it.next() {
        Some(a) => a,
        None => {
            eprintln!("Usage: <archive> <dictionary>");
            return None;
        }
    };

    let diccionario = match it.next() {
        Some(d) => d,
        None => {
            eprintln!("Usage: <archive> <dictionary>");
            return None;
        }
    };

    Some((archivo, diccionario))
}

pub fn verificar_directorio(brute_force_dir: &Path) -> bool {
    verify_directory(brute_force_dir)
}

pub fn cambiar_directorio(brute_force_dir: &Path) -> bool {
    change_directory(brute_force_dir)
}

pub fn ejecutar_fuerza_bruta(archivo: &str, diccionario: &str) -> bool {
    let path = Path::new(diccionario);
    run_bruteforce(archivo, path)
}
