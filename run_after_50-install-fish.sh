#!/usr/bin/env bash
# Build fish from its latest release tag; Sphinx is needed at build time for man pages.
set -euo pipefail

export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${PATH}"

command -v cargo >/dev/null && command -v uv >/dev/null || { echo "cargo or uv not found; skipping fish build"; exit 0; }

repo=https://github.com/fish-shell/fish-shell
latest="$(git ls-remote --tags --refs "$repo" | sed -n 's|.*refs/tags/\([0-9]*\.[0-9]*\.[0-9]*\)$|\1|p' | sort -V | tail -n1)" || true
[ -n "$latest" ] || { echo "could not read fish release tags; skipping fish build"; exit 0; }

installed="$(cargo install --list | sed -n 's|^fish v.*?tag=\([^#]*\)#.*|\1|p')"
[ "$latest" = "$installed" ] && exit 0

echo "cargo install fish ${latest}"
uv run --no-project --with sphinx cargo install --locked --force --git "$repo" --tag "$latest" fish
