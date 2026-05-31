if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Ruby user gem binaries
for gem_bin in $HOME/.local/share/gem/ruby/*/bin
    test -d $gem_bin; and fish_add_path --prepend --path $gem_bin
end

# Tool inits
bass source ~/.nvm/nvm.sh
starship init fish | source
zoxide init fish | source
