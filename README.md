# zven2crack

## Description
A brute-force tool for cracking password-protected ZIP and 7z archives using wordlists.

## Usage
### Compress a file with 7z and a password
To compress `pass.txt` with password `1234`, use:
```bash
7z a -p1234 -mhe=on pass.7z ~/Desktop/pass.txt
```

### Decompress rockyou.txt.gz
To extract `rockyou.txt.gz`, use:
```bash
gunzip rockyou.txt.gz
```
If you want to keep the compressed file and output the decompressed content, use:
```bash
gunzip -c rockyou.txt.gz > rockyou.txt
```

## Wordlists
This project utilizes password wordlists, including RockYou:

- **RockYou Wordlist**: The RockYou password list is a widely used wordlist for password cracking and security research. You can find it [here](https://github.com/praetorian-inc/Hob0Rules/blob/master/wordlists/rockyou.txt.gz).

## License
This project is released under the MIT License.

## Disclaimer
This tool is intended for ethical security research and testing on files you own or have explicit permission to audit. Misuse for unauthorized access is strictly prohibited.

