function ghostty-baseline --description 'Open the baseline tmux tabs in this Ghostty window'
    if set -q TMUX; or not set -q GHOSTTY_SURFACE_ID
        echo 'ghostty-baseline: run from a plain Ghostty shell, not inside tmux' >&2
        return 1
    end
    for tab in 'local terminal' 'local media' 'theta terminal' 'pi terminal' 'tau terminal' 'psi terminal' 'omega terminal'
        ghostty +new-tab --surface-id=$GHOSTTY_SURFACE_ID -e fish -c "tmux-session $tab"
    end
    tmux-session local dev
end
