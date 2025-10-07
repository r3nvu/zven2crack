# zven2crack

![GitHub](https://img.shields.io/badge/Platform-Linux-success)
![Rust](https://img.shields.io/badge/Built_with-Rust-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

Professional-grade tool for automated password recovery of 7z archives using dictionary attacks. Built with Rust for maximum performance.

## Installation and usage

This project includes `setup.sh` which builds the release binary and optionally installs a system-wide wrapper called `zven2crack`.

Installation (requires sudo to copy into /usr/local/bin):

```bash
git clone https://github.com/r3nvu/zven2crack.git
cd zven2crack
chmod +x setup.sh
./setup.sh
```

After successful installation you can run:

```bash
zven2crack <archive.7z> use <dictionary_path>
zven2crack <archive.7z> gen <output> <min_len> <max_len> <charset>
```

Examples:

- Use an existing dictionary:

```bash
zven2crack secret.7z use /path/to/dictionary.txt
```

- Generate a small dictionary example:

```bash
# Generate all combinations of 'ab' with length 1..2
zven2crack secret.7z gen /tmp/mydict.txt 1 2 ab
```

Note: generated dictionaries can become very large. Use small parameters for testing.

Expected output (if password is found):

[✓] Password found: "pass"
