function git-stash-clear-interactive --description 'Confirm before clearing the git stash'
    set -l stashed (command git rev-list --walk-reflogs --count refs/stash -- 2>/dev/null)
    or return 1
    if test $stashed -gt 0
        read -P "Clear $stashed stashed state(s) [y/N]? " -n 1 -l confirm
        echo
        if test "$confirm" = y -o "$confirm" = Y
            command git stash clear
        end
    end
end
