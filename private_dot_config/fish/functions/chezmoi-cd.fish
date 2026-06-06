function chezmoi-cd --wraps 'chezmoi cd' --description 'cd into the chezmoi source directory'
    set -l dir (chezmoi source-path $argv)
    or return
    cd $dir
end
