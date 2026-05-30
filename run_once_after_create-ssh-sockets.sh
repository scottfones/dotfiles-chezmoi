#!/usr/bin/env bash
# Ensure the SSH ControlPath socket dir exists (SSH won't create it itself).
# No-op where it already exists; the point is fresh-machine provisioning.
set -euo pipefail
mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh/sockets
