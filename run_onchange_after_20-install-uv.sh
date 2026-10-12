#!/usr/bin/env bash
# Install user-level uv.
set -euo pipefail

[ -x "${HOME}/.local/bin/uv" ] && exit 0
curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
