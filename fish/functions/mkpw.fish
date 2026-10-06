function mkpw --description 'Generate a random password'
    set -l length $argv[1]
    set -l alphabet $argv[2]
    test -n "$length"; or set length 32
    test -n "$alphabet"; or set alphabet '[:alnum:]'
    LC_CTYPE=C tr -dc $alphabet </dev/urandom | head -c $length
    echo
end
