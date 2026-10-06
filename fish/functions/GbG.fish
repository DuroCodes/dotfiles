function GbG --description 'Delete local branches whose upstream is gone'
    set -l branches (git-branch-remote-tracking gone)
    if test (count $branches) -gt 0
        git branch --delete --force $branches
    end
end
