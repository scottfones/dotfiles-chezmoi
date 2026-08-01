if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Reset systemd environment variables
if not set -q __SHELL_ENV_IMPORTED
    if test -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator
        bass 'while IFS= read -r l; do [ -n "$l" ] && eval "export $l"; done < <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)'
        set -l seen
        for p in $PATH
            contains -- $p $seen; or set -a seen $p
        end
        set -gx PATH $seen
        set -gx __SHELL_ENV_IMPORTED 1
    end
end

abbr -a chcd "cd (chezmoi source-path)"
abbr -a vim nvim

# Ruby user gem binaries
for gem_bin in $HOME/.local/share/gem/ruby/*/bin
    test -d $gem_bin; and fish_add_path --prepend --path $gem_bin
end

# Tool inits
bass source ~/.nvm/nvm.sh
starship init fish | source
zoxide init fish | source

direnv hook fish | source
