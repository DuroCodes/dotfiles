# Completion for @antfu/ni's `nr`, matching ~/.zim/custom/ni-completions/_ni
complete -c nr -f -a '(nr --completion (commandline -opc)[2..-1])'
