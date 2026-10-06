# Interactive fish config — prompt, completions, and session behaviour.
# Aliases live in conf.d/; functions are autoloaded from functions/.

set -g fish_greeting

if not status is-interactive
    return
end

starship init fish | source
functions --copy fish_prompt __starship_fish_prompt
function fish_prompt
    if set -q __starship_skip_newline
        set --erase __starship_skip_newline
    else if set -q __starship_prompt_ready
        echo
    end
    set -g __starship_prompt_ready 1
    __starship_fish_prompt
end

# Fish 4.8 embeds cd.fish, so copy it before zoxide tries to read the old path.
functions --copy cd __zoxide_cd_internal
zoxide init fish --cmd cd | source
fzf --fish | source
