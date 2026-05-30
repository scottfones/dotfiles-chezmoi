function ls --wraps lsd --description 'alias ls lsd --group-dirs first'
    lsd --group-dirs first --classify --total-size $argv
end
