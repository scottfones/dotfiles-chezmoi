if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set -gx RUSTC_WRAPPER sccache

# theme
# source ~/.config/fish/themes/kanagawa.fish

# Ruby user gem binaries (e.g. neovim-ruby-host, bundler if installed)
for gem_bin in $HOME/.local/share/gem/ruby/*/bin
    test -d $gem_bin; and fish_add_path --prepend --path $gem_bin
end

# nvm, npm, node
bass source ~/.nvm/nvm.sh

# source /home/scott/.python_general_venv/bin/activate.fish
starship init fish | source
zoxide init fish | source
