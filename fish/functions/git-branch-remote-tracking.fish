function git-branch-remote-tracking --description 'List local branches whose upstream matches the given track state'
    set -l track $argv[1]
    set -l extra $argv[2]
    set -l lines (command git branch --format '%(refname:short) %(upstream:track,nobracket)')
    or return 1

    for line in $lines
        set -l parts (string split ' ' $line)
        if test "$parts[2]" = "$track" -a "$parts[4]" = "$extra"
            echo $parts[1]
        end
    end
end
