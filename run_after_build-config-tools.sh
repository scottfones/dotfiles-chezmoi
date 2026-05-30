#!/usr/bin/env bash
# Build the externally-cloned Rust tools so the prompt/statusline work.
# Runs after externals are fetched. cargo's incremental check makes the
# up-to-date case a fast no-op.
set -euo pipefail

command -v cargo >/dev/null || { echo "cargo not found; skipping tool build"; exit 0; }
# ~/.cargo/config.toml sets rustc-wrapper=sccache; build without it if absent.
command -v sccache >/dev/null || export RUSTC_WRAPPER=

for tool in claude-starship-rs git-last-commit-rs; do
    dir="${HOME}/.config/${tool}"
    if [ -f "${dir}/Cargo.toml" ]; then
        echo "building ${tool}"
        cargo build --release --locked --manifest-path "${dir}/Cargo.toml"
    fi
done
