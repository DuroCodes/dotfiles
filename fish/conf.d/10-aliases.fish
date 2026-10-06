if not status is-interactive
    return
end

# reload / clear
alias s 'exec fish'
alias c clear

# shortcuts
alias pn pnpm
alias py python3
alias nv nvim
alias g git
alias code cursor

# ls via lsd
alias ls lsd
alias tree 'ls --tree -I node_modules'
