function git-dir --description 'Print the absolute path of the current .git directory'
    set -l git_dir (command git rev-parse --git-dir)
    or return
    realpath $git_dir
end
