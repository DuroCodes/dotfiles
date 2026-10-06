function mp4 --description 'Convert a .mov file to .mp4 with ffmpeg'
    if test -z "$argv[1]"
        echo "Usage: mp4 <file.mov>" >&2
        return 1
    end

    if not test -f "$argv[1]"
        echo "File not found: $argv[1]" >&2
        return 1
    end

    set -l out (path change-extension .mp4 "$argv[1]")
    ffmpeg -i "$argv[1]" -c:v libx264 -pix_fmt yuv420p -movflags +faststart -c:a aac "$out"
end
