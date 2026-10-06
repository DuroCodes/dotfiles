# zim git module aliases, using the default `G` prefix.

if not status is-interactive
    return
end

set -g _git_log_fuller_format '%C(bold yellow)commit %H%C(auto)%d%n%C(bold)Author: %C(blue)%an <%ae> %C(cyan)%ai (%ar)%n%C(bold)Commit: %C(blue)%cn <%ce> %C(cyan)%ci (%cr)%C(reset)%n%+B'
set -g _git_log_oneline_format '%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)'
set -g _git_log_oneline_medium_format '%C(bold yellow)%h%C(reset) %<(50,trunc)%s %C(bold blue)%an %C(cyan)%as (%ar)%C(auto)%d%C(reset)'

alias G git

# Branch (b)
alias Gb 'git branch'
alias Gbc 'git checkout -b'
alias Gbd 'git checkout --detach'
alias Gbl 'git branch --list -vv'
alias GbL 'git branch --list -vv --all'
alias Gbn 'git branch --no-contains'
alias Gbm 'git branch --move'
alias GbM 'git branch --move --force'
alias GbR 'git branch --force'
alias Gbs 'git show-branch'
alias GbS 'git show-branch --all'
alias Gbu 'git branch --unset-upstream'
alias Gbx git-branch-delete-interactive
alias GbX 'git-branch-delete-interactive --force'

# Commit (c)
alias Gc 'git commit --verbose'
alias Gca 'git commit --verbose --all'
alias GcA 'git commit --verbose --patch'
alias Gcm 'git commit --message'
alias Gco 'git checkout'
alias GcO 'git checkout --patch'
alias Gcf 'git commit --amend --reuse-message HEAD'
alias GcF 'git commit --verbose --amend'
alias Gcp 'git cherry-pick'
alias GcP 'git cherry-pick --no-commit'
alias Gcr 'git revert'
alias GcR 'git reset HEAD^'
alias Gcs 'git show --pretty=format:"$_git_log_fuller_format"'
alias GcS 'git commit --verbose -S'
alias Gcu 'git commit --fixup'
alias GcU 'git commit --squash'
alias Gcv 'git verify-commit'

# Conflict (C)
alias GCl 'git --no-pager diff --name-only --diff-filter=U'
alias GCa 'git add (GCl)'
alias GCe 'git mergetool (GCl)'
alias GCo 'git checkout --ours --'
alias GCO 'GCo (GCl)'
alias GCt 'git checkout --theirs --'
alias GCT 'GCt (GCl)'

# Data (d)
alias Gd 'git ls-files'
alias Gdc 'git ls-files --cached'
alias Gdx 'git ls-files --deleted'
alias Gdm 'git ls-files --modified'
alias Gdu 'git ls-files --other --exclude-standard'
alias Gdk 'git ls-files --killed'
alias Gdi 'git status --porcelain --ignored=matching | sed -n "s/^!! //p"'
alias GdI 'git ls-files --ignored --exclude-per-directory=.gitignore --cached'

# Fetch (f)
alias Gf 'git fetch'
alias Gfa 'git fetch --all'
alias Gfp 'git fetch --all --prune'
alias Gfc 'git clone'
alias Gfm 'git pull --no-rebase'
alias Gfr 'git pull --rebase'
alias Gfu 'git pull --ff-only --all --prune'

# Grep (g)
alias Gg 'git grep'
alias Ggi 'git grep --ignore-case'
alias Ggl 'git grep --files-with-matches'
alias GgL 'git grep --files-without-match'
alias Ggv 'git grep --invert-match'
alias Ggw 'git grep --word-regexp'

# Help (h)
alias Gh 'git help'
alias Ghw 'git help --web'

# Index (i)
alias Gia 'git add --verbose'
alias GiA 'git add --patch'
alias Giu 'git add --verbose --update'
alias GiU 'git add --verbose --all'
alias Gid 'git diff --no-ext-diff --cached'
alias GiD 'git diff --no-ext-diff --cached --word-diff'
alias Gir 'git reset'
alias GiR 'git reset --patch'
alias Gix 'git rm --cached -r'
alias GiX 'git rm --cached -rf'

# Log (l)
alias Gl 'git log --date-order --pretty=format:"$_git_log_fuller_format"'
alias Gls 'git log --date-order --stat --pretty=format:"$_git_log_fuller_format"'
alias Gld 'git log --date-order --stat --patch --pretty=format:"$_git_log_fuller_format"'
alias Glf 'git log --date-order --stat --patch --follow --pretty=format:"$_git_log_fuller_format"'
alias Glo 'git log --date-order --pretty=format:"$_git_log_oneline_format"'
alias GlO 'git log --date-order --pretty=format:"$_git_log_oneline_medium_format"'
alias Glg 'git log --date-order --graph --pretty=format:"$_git_log_oneline_format"'
alias GlG 'git log --date-order --graph --pretty=format:"$_git_log_oneline_medium_format"'
alias Glv 'git log --date-order --show-signature --pretty=format:"$_git_log_fuller_format"'
alias Glc 'git shortlog --summary --numbered'
alias Glr 'git reflog'

# Merge (m)
alias Gm 'git merge'
alias Gma 'git merge --abort'
alias Gmc 'git merge --continue'
alias GmC 'git merge --no-commit'
alias GmF 'git merge --no-ff'
alias Gms 'git merge --squash'
alias GmS 'git merge -S'
alias Gmv 'git merge --verify-signatures'
alias Gmt 'git mergetool'

# Push (p)
alias Gp 'git push'
alias Gpf 'git push --force-with-lease'
alias GpF 'git push --force'
alias Gpa 'git push --all'
alias GpA 'git push --all && git push --tags --no-verify'
alias Gpt 'git push --tags'
alias Gpc 'git push --set-upstream origin (git-branch-current 2>/dev/null)'
alias Gpp 'git pull origin (git-branch-current 2>/dev/null) && git push origin (git-branch-current 2>/dev/null)'

# Rebase (r)
alias Gr 'git rebase'
alias Gra 'git rebase --abort'
alias Grc 'git rebase --continue'
alias Gri 'git rebase --interactive --autosquash'
alias Grs 'git rebase --skip'
alias GrS 'git rebase --exec "git commit --amend --no-edit --no-verify -S"'

# Remote (R)
alias GR 'git remote'
alias GRl 'git remote --verbose'
alias GRa 'git remote add'
alias GRx 'git remote rm'
alias GRm 'git remote rename'
alias GRu 'git remote update'
alias GRp 'git remote prune'
alias GRs 'git remote show'
alias GRS 'git remote set-url'

# Stash (s)
alias Gs 'git stash'
alias Gsa 'git stash apply'
alias Gsx 'git stash drop'
alias GsX git-stash-clear-interactive
alias Gsl 'git stash list'
alias Gsd 'git stash show --patch --stat'
alias Gsp 'git stash pop'
alias Gsr git-stash-recover
alias Gss 'git stash save --include-untracked'
alias GsS 'git stash save --patch --no-keep-index'
alias Gsw 'git stash save --include-untracked --keep-index'
alias Gsi 'git stash push --staged'
alias Gsu 'git stash show --patch | git apply --reverse'

# Submodule (S)
alias GS 'git submodule'
alias GSa 'git submodule add'
alias GSf 'git submodule foreach'
alias GSi 'git submodule init'
alias GSI 'git submodule update --init --recursive'
alias GSl 'git submodule status'
alias GSm git-submodule-move
alias GSs 'git submodule sync'
alias GSu 'git submodule update --remote'
alias GSx git-submodule-remove

# Tag (t)
alias Gt 'git tag'
alias Gtl 'git tag --list --sort=-committerdate'
alias Gts 'git tag --sign'
alias Gtv 'git verify-tag'
alias Gtx 'git tag --delete'

# Main working tree (w)
alias Gws 'git status --short --branch'
alias GwS 'git status'
alias Gwd 'git diff --no-ext-diff'
alias GwD 'git diff --no-ext-diff --word-diff'
alias Gwr 'git reset --soft'
alias GwR 'git reset --hard'
alias Gwc 'git clean --dry-run'
alias GwC 'git clean -d --force'
alias Gwm 'git mv'
alias GwM 'git mv -f'
alias Gwx 'git rm -r'
alias GwX 'git rm -rf'

# Working trees (W)
alias GW 'git worktree'
alias GWa 'git worktree add'
alias GWl 'git worktree list'
alias GWm 'git worktree move'
alias GWp 'git worktree prune'
alias GWx 'git worktree remove'
alias GWX 'git worktree remove --force'

# Switch (y)
alias Gy 'git switch'
alias Gyc 'git switch --create'
alias Gyd 'git switch --detach'

# Misc
alias G.. 'cd (git-root 2>/dev/null; or echo .)'
alias G\? git-alias-lookup
