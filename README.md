# zven2crack
![GitHub](https://img.shields.io/badge/Platform-Linux-success)
![Rust](https://img.shields.io/badge/Built_with-Rust-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

Professional-grade tool for automated password recovery of 7z archives using dictionary attacks. Built with Rust for maximum performance.

### Automated Setup
Execute the installation script to configure all dependencies:

```bash
chmod +x run.sh  # Set executable permissions
./run.sh         # Run system update & install dependencies

## 🚀 Usage Guide

cargo run <PATH_TO_7Z> <DICTIONARY_FILE>
```

**Parameters:**
- `<PATH_TO_7Z>`: Target 7z/zip archive
- `<DICTIONARY_FILE>`: Password dictionary text file

### Example Attack
```bash
cargo run --release ./targetz/test_target.7z ./dictionaries/10k-worst-passwords.txt
```

### Expected Output
```
[✓] Password found: "s3cr3t_p@ss"
```
