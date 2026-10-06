function clear --wraps clear --description 'Clear screen without a leading blank prompt line'
    command clear $argv
    set -g __starship_skip_newline 1
end
