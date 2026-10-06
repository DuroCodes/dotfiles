function git-submodule-move --description 'Move a git submodule to a new path'
    set -l git_root (git-root)
    or return 1

    if test (count $argv) -ne 2
        echo "usage: git-submodule-move <source> <destination>" >&2
        return 2
    end

    set -l src $argv[1]
    set -l dst $argv[2]
    set -l url (command git -C $git_root config --file .gitmodules --get submodule.$src.url)
    if test -z "$url"
        echo "git-submodule-move: submodule not found: $src" >&2
        return 1
    end

    mkdir -p (dirname $dst)
    and git-submodule-remove $src
    and command git -C $git_root submodule add $url $dst
end
