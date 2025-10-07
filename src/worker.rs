use std::{fs::File, io::{BufRead, BufReader}, process::{Command, Stdio}, sync::{atomic::{AtomicBool, Ordering}, Arc}, thread};
use anyhow::{Result, bail};
use crossbeam_channel::bounded;

pub fn run_worker(archive: &str, dict_path: &str) -> Result<()> {
    let passwords = load_dictionary(dict_path)?;
    let found = Arc::new(AtomicBool::new(false));
    let (tx, rx) = bounded(100);
    let num_workers = num_cpus::get();
    let mut handles = Vec::new();
    for _ in 0..num_workers {
        let rx = rx.clone();
        let archive = archive.to_string();
        let found = Arc::clone(&found);
        let handle = thread::spawn(move || {
            while !found.load(Ordering::Relaxed) {
                match rx.recv() {
                    Ok(pw) => {
                        if found.load(Ordering::Relaxed) {
                            break;
                        }
                        let status = Command::new("7z")
                            .args(&["t", &format!("-p{}", pw), &archive])
                            .stdout(Stdio::null())
                            .stderr(Stdio::null())
                            .status();
                        if let Ok(s) = status {
                            if s.success() {
                                found.store(true, Ordering::Relaxed);
                                println!("Password found: {}", pw);
                                break;
                            }
                        }
                    }
                    Err(_) => break,
                }
            }
        });
        handles.push(handle);
    }
    for pw in passwords {
        if found.load(Ordering::Relaxed) {
            break;
        }
        if tx.send(pw).is_err() {
            break;
        }
    }
    drop(tx);
    for handle in handles {
        let _ = handle.join();
    }
    if !found.load(Ordering::Relaxed) {
        bail!("Password not found");
    }
    Ok(())
}

fn load_dictionary(path: &str) -> Result<Vec<String>> {
    let file = File::open(path)
        .map_err(|e| anyhow::anyhow!("Failed to open dictionary file {}: {}", path, e))?;
    let reader = BufReader::new(file);
    let lines = reader
        .lines()
        .filter_map(Result::ok)
        .map(|s| s.trim().to_string())
        .collect();
    Ok(lines)
}
