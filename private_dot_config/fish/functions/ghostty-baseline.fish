function ghostty-baseline --description 'Open the baseline tmux tabs in this Ghostty window'
    if set -q TMUX; or not set -q GHOSTTY_SURFACE_ID
        echo 'ghostty-baseline: run from a plain Ghostty shell, not inside tmux' >&2
        return 1
    end
    for tab in local:terminal local:media theta:terminal pi:terminal tau:terminal psi:terminal omega:terminal
        set -l host_session (string split : -- $tab)
        set -l attach tmux -u new-session -A -D -s $host_session[2]
        if test $host_session[1] != local
            set attach ssh -t $host_session[1] $attach
        end
        ghostty +new-tab --surface-id=$GHOSTTY_SURFACE_ID -e $attach
    end
    exec tmux -u new-session -A -D -s dev
end
