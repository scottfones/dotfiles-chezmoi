#!/bin/sh
# Print this host's Greek glyph when the attached tmux client is remote.
# Takes the tmux client pid, whose environment tracks the real connection.
# Host map mirrors glyphs.host in ~/.config/wezterm/glyph_identifiers.lua
# The leading space lives here so nothing is emitted at all when local.
[ -n "$1" ] || exit 0
grep -qz '^SSH_CONNECTION=' "/proc/$1/environ" 2>/dev/null || exit 0

case $(uname -n) in
    zeta)  printf ' Ζ' ;; # Zeta
    theta) printf ' Θ' ;; # Theta
    pi)    printf ' Π' ;; # Pi
    psi)   printf ' Ψ' ;; # Psi
    omega) printf ' Ω' ;; # Omega
    *)     printf ' %s' "$(uname -n)" ;;
esac
