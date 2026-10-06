# Personal aliases from ~/.zshrc, plus the zim utility aliases you already had.

if not status is-interactive
    return
end

# Reload / clear
alias s 'exec fish'
alias c clear

# Shortcuts
alias pn pnpm
alias py python3
alias nv nvim
alias g git
alias code cursor
alias ff fastfetch

# ls via lsd (same as `alias ls=lsd` in zsh)
alias ls lsd
alias ll 'ls -lh'
alias l 'll -A'
alias lm 'll -A | $PAGER'
alias lk 'll -Sr'
alias lt 'll -tr'
alias lr 'll --tree'
alias lx 'll -X'
alias tree 'ls --tree -I node_modules'

# zim utility
alias df 'df -h'
alias du 'du -h'
alias grep 'grep --color=auto'
alias get 'wget --continue --progress=bar --timestamping'
