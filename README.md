```markdown
# 🔐 Zven2Crack - 7z Password Cracking Automation

Professional-grade tool for automated password recovery of 7z archives using dictionary attacks. Built with Rust for maximum performance.

![GitHub](https://img.shields.io/badge/Platform-Linux-success)
![Rust](https://img.shields.io/badge/Built_with-Rust-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

## 📦 Project Overview

Automated password cracking solution for `.7z` archives using customizable password dictionaries. Password lists are stored in the `dictionaries` directory.

```bash
cargo run <7z_file> <dictionary_path>
```

## 🛠 Installation & Build Guide

### System Requirements
- Linux distribution (Ubuntu/Debian recommended)
- Terminal with `sudo` privileges
- Minimum 2GB RAM (for large dictionaries)

### Automated Setup
Execute the installation script to configure all dependencies:

```bash
chmod +x run.sh  # Set executable permissions
./run.sh         # Run system update & install dependencies
```

**Script Operations:**
- System package updates
- Installation of essential tools (`build-essential`, `curl`)
- Rust toolchain installation via `rustup`
- Environment configuration for Rust development

### Manual Environment Setup
Add to `~/.bashrc` (if not automated):

```bash
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$CARGO_HOME/bin:$PATH"
```

### Compilation Instructions
Build and execute the project:

```bash
cd zven2crack
cargo build --release  # Optimized build
cargo run --release    # Execute optimized binary
```

## 🚀 Usage Guide

### Command Syntax
```bash
cargo run --release <PATH_TO_7Z> <DICTIONARY_FILE>
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
[✓] Password found: "s3cr3t_p@ss" (Attempts: 428)
```

## 💡 Operational Notes
- Dictionary Selection: Larger dictionaries (10k+ entries) yield better results
- Performance: Multi-threaded implementation optimizes testing speed
- Continuity: Process persists through entire dictionary until success
- Supported Formats: 7z and ZIP archive formats

## 🤝 Contribution Guidelines
We welcome security improvements and performance enhancements! Please:
1. Fork the repository
2. Create feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -am 'Add security enhancement'`)
4. Push branch (`git push origin feature/improvement`)
5. Open Pull Request

---

**Security Note:** Use only on archives you own or have legal permission to test.
```

This professional Markdown format includes:
- Security badges for quick visual recognition
- Clean command syntax highlighting
- System requirement specifications
- Optimized build instructions (`--release` flag)
- Clear parameter documentation
- Contribution workflow guidelines
- Responsive formatting for GitHub rendering
- Emoji-enhanced section headers for better scanability
- Security disclaimer for ethical usage

The structure emphasizes technical precision while maintaining readability across devices.
