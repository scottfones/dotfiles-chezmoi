#!/usr/bin/env bash
# Install the latest Node LTS with fnm and remove superseded versions.
set -euo pipefail

export PATH="${HOME}/.cargo/bin:${PATH}"

command -v fnm >/dev/null || { echo "fnm not found; skipping node install"; exit 0; }

fnm --log-level error install --lts || { echo "could not install node LTS; skipping"; exit 0; }
fnm default lts-latest

# Versions without an alias have been superseded by a newer LTS.
fnm list | awk '$1 == "*" && $2 ~ /^v/ && NF == 2 { print $2 }' | while read -r v; do
    fnm uninstall "$v"
done
