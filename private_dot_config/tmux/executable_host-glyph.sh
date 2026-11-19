#!/bin/sh
# Print " <glyph>" when the tmux client is remote. Print nothing when local.
# $1: tmux client pid. Its environment tracks the real connection.
# $2: host glyph from the tmux option @host_glyph.
[ -n "$1" ] || exit 0
grep -qz '^SSH_CONNECTION=' "/proc/$1/environ" 2>/dev/null || exit 0
printf ' %s' "$2"
