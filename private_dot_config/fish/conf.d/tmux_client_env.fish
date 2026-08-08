# Track the attached tmux client's environment on every prompt
function __tmux_sync_client_env --on-event fish_prompt
    test -n "$TMUX"; or return

    set -l tmux_env (tmux show-environment 2>/dev/null)
    for var in SSH_CONNECTION DISPLAY WAYLAND_DISPLAY
        set -l entry (string match -r -- "^$var=.*" $tmux_env)
        if test -n "$entry"
            set -gx $var (string replace -r -- "^$var=" '' $entry)
        else
            set -e $var
        end
    end
end
