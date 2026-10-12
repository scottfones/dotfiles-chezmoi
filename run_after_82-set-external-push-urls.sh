#!/usr/bin/env bash
# Add ssh push to externally managed git repos.
set -euo pipefail

command -v git >/dev/null || exit 0

for repo in nvim claude-starship-rs git-last-commit-rs; do
  dir="${HOME}/.config/${repo}"
  [ -d "${dir}/.git" ] || continue
  ssh_url="git@github.com:scottfones/${repo}.git"
  current="$(git -C "${dir}" remote get-url --push origin 2>/dev/null || true)"
  if [ "${current}" != "${ssh_url}" ]; then
    git -C "${dir}" remote set-url --push origin "${ssh_url}"
    echo "push url for ${repo} -> ${ssh_url}"
  fi
done
