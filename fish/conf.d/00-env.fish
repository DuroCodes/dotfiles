# Environment for all fish sessions (interactive and scripts).
# Mirrors ~/.zprofile, ~/.zshenv, and the PATH/export block in ~/.zshrc.

/opt/homebrew/bin/brew shellenv fish | source

set -gx BUN_INSTALL $HOME/.bun
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx GOPATH $HOME/go
set -gx PICO_SDK_PATH $HOME/Programming/pico/pico-sdk

if not set -q PAGER
    set -gx PAGER less
end
if not set -q LESS
    set -gx LESS '--ignore-case --jump-target=4 --LONG-PROMPT --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'
end

if not set -q NO_COLOR
    if not set -q GREP_COLOR
        set -gx GREP_COLOR '37;45'
    end
    if not set -q GREP_COLORS
        set -gx GREP_COLORS "mt=$GREP_COLOR"
    end
    set -gx CLICOLOR 1
    if not set -q LSCOLORS
        set -gx LSCOLORS ExfxcxdxbxGxDxabagacad
    end
    if not set -q LESS_TERMCAP_mb
        set -gx LESS_TERMCAP_mb (printf '\e[1;31m')
        set -gx LESS_TERMCAP_md (printf '\e[1;31m')
        set -gx LESS_TERMCAP_me (printf '\e[0m')
        set -gx LESS_TERMCAP_ue (printf '\e[0m')
        set -gx LESS_TERMCAP_us (printf '\e[1;32m')
    end
end

# Prepend user toolchains. Later calls sit further left on PATH.
fish_add_path -g $HOME/.spicetify
fish_add_path -g $GOPATH/bin
fish_add_path -g $HOME/.local/bin
fish_add_path -g $PNPM_HOME
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $BUN_INSTALL/bin
fish_add_path -g /opt/homebrew/opt/libpq/bin
fish_add_path -g "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

if command -q fnm
    fnm env --use-on-cd --shell fish | source
end

if command -q pyenv
    pyenv init - fish | source
end
