function temps --description 'Show CPU and GPU temperature'
    set -l cpu (smctemp -c)°C
    or return
    set -l gpu (smctemp -g)°C
    or return

    set -l w0 (math "max(3, "(string length -- $cpu)")")
    set -l w1 (math "max(3, "(string length -- $gpu)")")
    set -l h0 (string repeat --count (math "$w0 + 2") -- '─')
    set -l h1 (string repeat --count (math "$w1 + 2") -- '─')

    printf '╭%s┬%s╮\n' $h0 $h1
    printf '│ %-*s │ %-*s │\n' $w0 CPU $w1 GPU
    printf '├%s┼%s┤\n' $h0 $h1
    printf '│ %-*s │ %-*s │\n' $w0 $cpu $w1 $gpu
    printf '╰%s┴%s╯\n' $h0 $h1
end
