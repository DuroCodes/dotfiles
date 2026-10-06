function git-stash-recover --description 'Recover stash refs from commit hashes'
    command git rev-parse --is-inside-work-tree >/dev/null
    or return 1

    if test (count $argv) -eq 0
        echo "usage: git-stash-recover <commit...>" >&2
        return 2
    end

    for commit in $argv
        command git update-ref \
            -m (command git log -1 --pretty=format:%s $commit) \
            refs/stash $commit
    end
end
