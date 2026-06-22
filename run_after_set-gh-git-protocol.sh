#!/usr/bin/env bash
# set gh cli to ssh.

set -euo pipefail
command -v gh >/dev/null || exit 0
gh config set git_protocol ssh
