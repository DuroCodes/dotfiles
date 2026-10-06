function git-branch-delete-interactive --description 'Delete a branch and optionally its upstream remote'
    set -l remotes
    if contains -- --remotes $argv; or contains -- -r $argv
        for arg in $argv
            if not string match -q -- '-*' $arg
                set -a remotes $arg
            end
        end
    else
        for arg in $argv
            if string match -q -- '-*' $arg
                continue
            end
            set -l upstream (command git rev-parse --abbrev-ref $arg@{u} 2>/dev/null)
            and set -a remotes $upstream
        end
    end

    command git branch --delete $argv
    or return

    if test (count $remotes) -eq 0
        return
    end

    read -P "Also delete remote branch(es) $remotes [y/N]? " -n 1 -l confirm
    echo
    if test "$confirm" = y -o "$confirm" = Y
        for remote in $remotes
            set -l parts (string split -m 1 / $remote)
            command git push $parts[1] :$parts[2]
        end
    end
end
