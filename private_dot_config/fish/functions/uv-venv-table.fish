function uv-venv-table --description 'List Python venvs with the interpreter each uses'
    fd --hidden --no-ignore '^pyvenv\.cfg$' $HOME \
        --exclude .git --exclude node_modules \
        -x awk -F' = ' -v dir={//} '$1 == "home" { print $2 "\t" dir }' {} \
        | sort
end
