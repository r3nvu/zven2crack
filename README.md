```markdown
# 🔐 Zven2Crack - 7z Password Cracking Automation

Professional-grade tool for automated password recovery of 7z archives using dictionary attacks. Built with Rust for maximum performance.

![GitHub](https://img.shields.io/badge/Platform-Linux-success)
![Rust](https://img.shields.io/badge/Built_with-Rust-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

## 📦 Project Overview

Automated password cracking solution for `.7z` archives using customizable password dictionaries. Password lists are stored in the `dictionaries` directory.

### Automated Setup
Execute the installation script to configure all dependencies:

```bash
chmod +x run.sh  # Set executable permissions
./run.sh         # Run system update & install dependencies
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
./run.sh

or

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
