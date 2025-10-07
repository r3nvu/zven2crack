
#!/usr/bin/env bash

# Simple launcher for zven2crack: uses the release binary if available,
#!/usr/bin/env bash

# zven2crack launcher: install, generate dictionaries, and run the embedded binary.

set -euo pipefail

RELEASE_BIN="target/release/zven2crack-main"

print_help() {
  cat <<'HELP'
Usage:
  ./zven2crack.sh install
      Install Rust (if needed), build release and install /usr/local/bin/zven2crack

  #!/usr/bin/env bash

  # zven2crack launcher: install, generate dictionaries, and run the embedded binary.

  set -euo pipefail

  RELEASE_BIN="target/release/zven2crack-main"

  print_help() {
    cat <<'HELP'
  Usage:
    ./zven2crack.sh install
        Install Rust (if needed), build release and install /usr/local/bin/zven2crack

    ./zven2crack.sh gen [--output path] [--min N] [--max M] [--charset CHARS]
        Generate a dictionary into the `dictionary/` folder. Defaults: min=1 max=4 charset=0123456789

    ./zven2crack.sh <archive.7z> <dictionary>
        Run the tool against an archive using a dictionary

    ./zven2crack.sh
        #!/usr/bin/env bash

        # Minimal clean zven2crack launcher.
        # Supports: install, gen, run archive, and interactive menu.

        set -euo pipefail

        RELEASE_BIN="target/release/zven2crack-main"

        print_help() {
          cat <<'HELP'
        Usage:
          ./zven2crack.sh install
              Build and install /usr/local/bin/zven2crack

          ./zven2crack.sh gen [--output path] [--min N] [--max M] [--charset CHARS]
              Generate a dictionary saved under the `dictionary/` folder.

          ./zven2crack.sh <archive.7z> <dictionary>
              Run the tool against an archive using a dictionary

          ./zven2crack.sh
              Start an interactive menu.

        HELP
        }

        install_rust_and_build() {
          echo "Building release binary..."
          cargo build --release

          BIN_SRC=""
          if [ -f "target/release/zven2crack" ]; then
            BIN_SRC="target/release/zven2crack"
          elif [ -f "target/release/zven2crack-main" ]; then
            BIN_SRC="target/release/zven2crack-main"
          fi

          if [ -z "$BIN_SRC" ]; then
            echo "Release binary not found after build. Aborting."
            exit 1
          fi

          echo "Installing to /usr/local/bin/zven2crack (may require sudo)..."
          #!/usr/bin/env bash

          # Clean zven2crack launcher: install, generate dictionaries, and run the embedded binary.

          set -euo pipefail

          RELEASE_BIN="target/release/zven2crack-main"

          print_help() {
            cat <<'HELP'
          Usage:
            ./zven2crack.sh install
                Build and install /usr/local/bin/zven2crack

            ./zven2crack.sh gen [--output path] [--min N] [--max M] [--charset CHARS]
                Generate a dictionary saved under the `dictionary/` folder.

            ./zven2crack.sh <archive.7z> <dictionary>
                Run the tool against an archive using a dictionary

            ./zven2crack.sh
                Start an interactive menu.

          HELP
          }

          install_rust_and_build() {
            echo "Building release binary..."
            cargo build --release

            BIN_SRC=""
            if [ -f "target/release/zven2crack" ]; then
              BIN_SRC="target/release/zven2crack"
            elif [ -f "target/release/zven2crack-main" ]; then
              BIN_SRC="target/release/zven2crack-main"
            fi

            if [ -z "$BIN_SRC" ]; then
              echo "Release binary not found after build. Aborting."
              exit 1
            fi

            echo "Installing to /usr/local/bin/zven2crack (may require sudo)..."
            sudo cp "$BIN_SRC" /usr/local/bin/zven2crack
            sudo chmod +x /usr/local/bin/zven2crack
            echo "Installed /usr/local/bin/zven2crack"
          }

          run_archive() {
            ARCHIVE="$1"
            DICT="$2"

            if [ ! -f "$ARCHIVE" ]; then
              echo "Archive not found: $ARCHIVE"; return 1
            fi
            if [ ! -f "$DICT" ]; then
              echo "Dictionary not found: $DICT"; return 1
            fi

            if [ -x "$RELEASE_BIN" ]; then
              exec "$RELEASE_BIN" "$ARCHIVE" "$DICT"
            else
              echo "Release binary not found; running via cargo (this will require Rust/Cargo)."
              exec cargo run --release -- "$ARCHIVE" "$DICT"
            fi
          }

          gen_dictionary() {
            OUT=""
            MIN=1
            MAX=4
            CHARSET="0123456789"

            while [ "$#" -gt 0 ]; do
              case "$1" in
                --output) OUT="$2"; shift 2;;
                --min) MIN="$2"; shift 2;;
                --max) MAX="$2"; shift 2;;
                --charset) CHARSET="$2"; shift 2;;
                --help|-h) echo "Usage: $0 gen [--output path] [--min N] [--max M] [--charset CHARS]"; return 0;;
                *) echo "Unknown gen arg: $1"; return 1;;
              esac
            done

            mkdir -p dictionary

            if [ -z "$OUT" ]; then
              TS=$(date +%s)
              OUT="dictionary/dict_${TS}.txt"
            else
              case "$OUT" in
                /*) ;;
                *) OUT="dictionary/$OUT";;
              esac
            fi

            echo "Generating dictionary at '$OUT' (min=$MIN max=$MAX) charset='$CHARSET'"

            export CHARSET MIN MAX
            python3 - <<'PY' >"$OUT"
          import os, itertools, sys
          charset = os.environ['CHARSET']
          min_len = int(os.environ['MIN'])
          max_len = int(os.environ['MAX'])
          out = sys.stdout
          for L in range(min_len, max_len+1):
              for prod in itertools.product(charset, repeat=L):
                  out.write(''.join(prod) + '\n')
          PY

            echo "Dictionary written to $OUT"
          }

          interactive_menu() {
            while true; do
              echo "Select action:"
              echo "  1) Run brute force against archive"
              echo "  2) Generate dictionary"
              echo "  3) Install (build + install)"
              echo "  4) Help"
              echo "  q) Quit"
              read -rp "Choice: " choice
              case "$choice" in
                1)
                  read -rp "Path to .7z archive: " archive
                  read -rp "Path to dictionary: " dict
                  run_archive "$archive" "$dict"
                  ;;
                2)
                  read -rp "Output filename (optional): " out
                  read -rp "Min length [1]: " min_len
                  read -rp "Max length [4]: " max_len
                  read -rp "Charset [0123456789]: " charset
                  min_len=${min_len:-1}
                  max_len=${max_len:-4}
                  charset=${charset:-0123456789}
                  if [ -z "$out" ]; then
                    gen_dictionary --min "$min_len" --max "$max_len" --charset "$charset"
                  else
                    gen_dictionary --output "$out" --min "$min_len" --max "$max_len" --charset "$charset"
                  fi
                  ;;
                3) install_rust_and_build ;;
                4) print_help ;;
                q|Q) exit 0 ;;
                *) echo "Unknown option" ;;
              esac
            done
          }

          # Dispatcher
          if [ "$#" -eq 0 ]; then
            interactive_menu
            exit 0
          fi

          case "$1" in
            install|setup) install_rust_and_build ;;
            gen) shift; gen_dictionary "$@" ;;
            help|-h|--help) print_help ;;
            *)
              if [ "$#" -eq 2 ]; then
                run_archive "$1" "$2"
              else
                print_help; exit 1
              fi
              ;;
          esac
      OUT=""

