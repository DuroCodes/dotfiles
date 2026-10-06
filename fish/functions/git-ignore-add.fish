function git-ignore-add --description 'Append paths to the repo .gitignore'
    set -l git_root (git-root)
    or return 1
    for file in $argv
        echo $file >>$git_root/.gitignore
    end
end
