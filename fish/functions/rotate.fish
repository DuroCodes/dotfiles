function rotate --description 'Rotate a video by a multiple of 90 degrees'
    argparse --name rotate cw ccw 'degrees=' -- $argv
    or return

    if set -q _flag_cw; and set -q _flag_ccw
        echo "rotate: --cw and --ccw cannot be used together" >&2
        return 1
    end

    if test (count $argv) -ne 1
        echo "Usage: rotate <file> [--cw | --ccw] [--degrees N]" >&2
        return 1
    end

    set -l file $argv[1]
    if not test -f $file
        echo "File not found: $file" >&2
        return 1
    end

    set -l degrees 90
    if set -q _flag_degrees
        set degrees $_flag_degrees
    end

    if not string match -qr '^-?[0-9]+$' -- $degrees
        echo "--degrees must be a multiple of 90." >&2
        return 1
    end
    if test (math "$degrees % 90") -ne 0
        echo "--degrees must be a multiple of 90." >&2
        return 1
    end

    set -l clockwise 1
    if set -q _flag_ccw
        set clockwise 0
    else if not set -q _flag_cw; and test $degrees -lt 0
        set clockwise 0
    end

    set -l turns (math -s 0 "abs($degrees) / 90 % 4")
    if test $clockwise -eq 0
        set turns (math -s 0 "(4 - $turns) % 4")
    end

    if test $turns -eq 0
        echo "Rotation is a multiple of 360. Nothing to do."
        return 0
    end

    set -l label
    set -l vf
    switch $turns
        case 1
            set label cw90
            set vf transpose=1
        case 2
            set label 180
            set vf "transpose=1,transpose=1"
        case 3
            set label ccw90
            set vf transpose=2
    end

    set -l ext (path extension $file)
    set -l stem (path change-extension '' $file)
    set -l out "$stem-$label$ext"

    ffmpeg -y -i $file -vf $vf -c:v libx264 -crf 18 -preset medium -pix_fmt yuv420p -c:a copy $out
    or begin
        echo "Processing failed. Error: ffmpeg failed" >&2
        return 1
    end

    set -l shown (string replace --all ' ' '\\ ' -- $out)
    echo "Done! Output: $shown"
end
