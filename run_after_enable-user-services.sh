#!/usr/bin/env bash
# Pick up newly-written user units and generate the LS_COLORS cache now,
# rather than waiting for the next login. The service self-guards on vivid.
set -euo pipefail

command -v systemctl >/dev/null || exit 0
systemctl --user daemon-reload
systemctl --user enable --now ls-colors-cache.service
