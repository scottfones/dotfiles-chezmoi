#!/usr/bin/env bash
# Install user-level rustup with stable and nightly toolchains.
set -euo pipefail

export PATH="${HOME}/.cargo/bin:${PATH}"

if [ ! -x "${HOME}/.cargo/bin/rustup" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain none
  rustup toolchain install stable nightly --component rust-analyzer --component llvm-tools
  rustup default nightly
fi
