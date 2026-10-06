function git-submodule-remove --description 'Remove a git submodule'
    set -l git_root (git-root)
    or return 1
    set -l git_dir (git-dir)
    or return 1

    if test (count $argv) -ne 1
        echo "usage: git-submodule-remove <path>" >&2
        return 2
    end

    set -l src $argv[1]
    if not command git -C $git_root config --file .gitmodules --get submodule.$src.path &>/dev/null
        echo "git-submodule-remove: submodule not found: $src" >&2
        return 1
    end

    command git -C $git_root config --file $git_dir/config --remove-section submodule.$src &>/dev/null
    command git -C $git_root config --file .gitmodules --remove-section submodule.$src &>/dev/null
    command git -C $git_root add .gitmodules
    command git -C $git_root rm --cached $src &>/dev/null
    command rm -rf $git_root/$src
    command rm -rf $git_dir/modules/$src
    return 0
end
