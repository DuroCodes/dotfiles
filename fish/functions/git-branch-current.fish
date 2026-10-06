function git-branch-current --description 'Print the current git branch name'
    command git symbolic-ref -q --short HEAD
end
