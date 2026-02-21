#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  jj_help.sh <command-path...>

Examples:
  jj_help.sh log
  jj_help.sh rebase
  jj_help.sh git push
  jj_help.sh help -k revsets
EOF
}

if [[ $# -eq 0 ]]; then
  usage
  exit 2
fi

if ! command -v jj >/dev/null 2>&1; then
  echo "error: 'jj' not found in PATH" >&2
  exit 127
fi

out_file="$(mktemp)"
err_file="$(mktemp)"
cleanup() {
  rm -f "$out_file" "$err_file"
}
trap cleanup EXIT

args=("$@")
if [[ "${args[0]}" == "jj" ]]; then
  args=("${args[@]:1}")
fi

if [[ ${#args[@]} -eq 0 ]]; then
  usage
  exit 2
fi

version="$(jj --version)"

# For nested commands (e.g. `git push`), direct `--help` is more reliable.
# For `help ...`, run `jj help ...` directly.
if [[ "${args[0]}" == "help" ]]; then
  if jj "${args[@]}" >"$out_file" 2>"$err_file"; then
    printf '[source] %s\n\n' "$version"
    cat "$out_file"
    exit 0
  fi
else
  if jj "${args[@]}" --help >"$out_file" 2>"$err_file"; then
    printf '[source] %s\n\n' "$version"
    cat "$out_file"
    exit 0
  fi
fi

if jj help "${args[@]}" >"$out_file" 2>"$err_file"; then
  printf '[source] %s\n\n' "$version"
  cat "$out_file"
  exit 0
fi

echo "error: failed to resolve help for: ${args[*]}" >&2
echo "hint: try 'jj --help' or 'jj help <command>'" >&2
echo "--- stderr from last attempt ---" >&2
cat "$err_file" >&2
exit 1
