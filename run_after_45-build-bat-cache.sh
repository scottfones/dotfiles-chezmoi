#!/usr/bin/env bash
# Build bat's theme cache when the tracked kanagawa theme is missing (fresh host or bat upgrade).
set -euo pipefail

export PATH="${HOME}/.cargo/bin:${PATH}"

command -v bat >/dev/null || exit 0

bat --list-themes 2>/dev/null | grep -qx kanagawa && exit 0
bat cache --build
