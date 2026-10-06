function git-root --description 'Print the root of the current git work tree'
    command git rev-parse --show-toplevel
end
