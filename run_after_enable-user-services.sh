#!/usr/bin/env bash
# Refresh systemd user units and generate required artifacts.
set -euo pipefail

command -v systemctl >/dev/null || exit 0
systemctl --user daemon-reload
systemctl --user enable --now ls-colors-cache.service
