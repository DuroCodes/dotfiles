function git-alias-lookup --description 'List zim-style G* git aliases'
    set -l pattern $argv
    set -l names (functions -n | string match -r '^G')
    if test (count $pattern) -gt 0
        set names (string match -r -- (string join '.*' $pattern) $names)
    end
    for name in $names
        set -l body (functions $name | string collect)
        set -l cmd (echo $body | string match -r 'git [^;\n]+' | head -1 | string trim)
        printf '%s\t%s\n' $name $cmd
    end | column -t -s \t
end
