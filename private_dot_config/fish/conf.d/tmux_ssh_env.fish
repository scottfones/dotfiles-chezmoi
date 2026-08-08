# A tmux pane inherits SSH_CONNECTION at creation and keeps it forever, so
# panes restored by continuum at boot never see one, and panes outlive the
# client that created them. tmux refreshes the session environment on every
# client attach (update-environment), so pull the live value from there each
# prompt to keep starship's [hostname] ssh_only tracking the attached client.
function __tmux_sync_ssh_env --on-event fish_prompt
    test -n "$TMUX"; or return

    set -l entry (tmux show-environment SSH_CONNECTION 2>/dev/null)
    if string match -q -- 'SSH_CONNECTION=*' $entry
        set -gx SSH_CONNECTION (string replace -r -- '^SSH_CONNECTION=' '' $entry)
    else
        set -e SSH_CONNECTION
    end
end
