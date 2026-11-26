function tmux-session --argument-names host session --description 'Attach this tab to a tmux session on a host'
    if set -q TMUX
        echo 'tmux-session: run from a plain shell, not inside tmux' >&2
        return 1
    end
    test -n "$host"; or set host (__tmux_session_hosts | fzf --prompt 'host> ' --height '~10'); or return
    test -n "$session"; or read -P "tmux session on $host: " -c terminal session; or return
    if not string match -qr '^[A-Za-z0-9_-]+$' -- $session
        echo "tmux-session: use only letters, digits, '_' and '-' in a session name" >&2
        return 1
    end
    set -l attach tmux -u new-session -A -D -s $session
    test "$host" = local; and exec $attach
    exec ssh -t $host $attach
end
