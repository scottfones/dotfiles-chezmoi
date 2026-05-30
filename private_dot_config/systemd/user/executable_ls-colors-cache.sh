#!/usr/bin/env bash
# Regenerate ~/.config/environment.d/ls-colors.conf from vivid output.
# Invoked by ls-colors-cache.service at user login. Wrapping the value in
# double quotes is required so the bashrc env.d sourcing loop sees a valid
# shell assignment (vivid output contains `;` which bash would otherwise
# treat as a statement separator).
set -euo pipefail

LS=$(vivid generate one-dark)
printf 'LS_COLORS="%s"\n' "$LS" > "$HOME/.config/environment.d/ls-colors.conf"
systemctl --user set-environment "LS_COLORS=$LS"
