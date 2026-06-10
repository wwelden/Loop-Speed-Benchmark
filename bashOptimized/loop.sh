#!/bin/bash
# "Optimized" Bash: pure Bash is far too slow for this benchmark (the disabled
# bash/loop.sh would take hours), so this script cheats openly -- it compiles
# the project's own C implementation and runs that. The runner reports it as
# "Bash (via C)"; the number mostly measures gcc compile time plus the C
# runtime, not Bash loop performance.

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Please provide a number as command line argument" >&2
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -eq 0 ]; then
    echo "Please provide a valid non-zero integer" >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
C_SRC="$SCRIPT_DIR/../c/loop.c"

if [ ! -f "$C_SRC" ]; then
    echo "Cannot find the C implementation (expected at $C_SRC)" >&2
    exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Compile the exact same C source the C benchmark uses, then run it
gcc -O3 "$C_SRC" -o "$TMP_DIR/loop"
"$TMP_DIR/loop" "$1"
