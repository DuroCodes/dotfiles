# Match zsh-syntax-highlighting + zsh-autosuggestions (Palenight ANSI).
# Fish 4.3+ keeps these as globals, not universals — set them every session.

set -g fish_color_normal normal
set -g fish_color_command green
set -g fish_color_keyword yellow
set -g fish_color_quote yellow
set -g fish_color_redirection yellow
set -g fish_color_end normal
set -g fish_color_error red --bold
set -g fish_color_param normal
set -g fish_color_valid_path --underline
set -g fish_color_option normal
set -g fish_color_comment brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_operator normal
set -g fish_color_escape cyan
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel --reverse
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_history_current --bold

set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow --italics
set -g fish_pager_color_selected_background --reverse
