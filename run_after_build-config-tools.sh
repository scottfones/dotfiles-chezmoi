#!/usr/bin/env bash
# Build the externally-cloned Rust tools.
set -euo pipefail

command -v cargo >/dev/null || {
  echo "cargo not found; skipping tool build"
  exit 0
}

# clear cargo sccache export if unavailable
command -v sccache >/dev/null || export RUSTC_WRAPPER=

for tool in claude-starship-rs git-last-commit-rs; do
  dir="${HOME}/.config/${tool}"
  if [ -f "${dir}/Cargo.toml" ]; then
    echo "building ${tool}"
    cargo build --release --locked --manifest-path "${dir}/Cargo.toml"
  fi
done
