function cmp --description 'Compress a video, or convert it to mp3'
    argparse --name cmp taskbar discord 'size=' tiny mp3 no-audio -- $argv
    or return

    if test (count $argv) -ne 1
        echo "Usage: cmp <file> [--taskbar] [--discord] [--size MB] [--tiny] [--mp3] [--no-audio]" >&2
        return 1
    end

    set -l file $argv[1]
    if not test -f $file
        echo "File not found: $file" >&2
        return 1
    end

    if set -q _flag_size
        if not string match -qr '^[0-9]+(\.[0-9]+)?$' -- $_flag_size
            echo "--size must be a positive number of megabytes." >&2
            return 1
        end
        if test (math $_flag_size) -le 0
            echo "--size must be a positive number of megabytes." >&2
            return 1
        end
    end

    if set -q _flag_size; or set -q _flag_discord
        set -l target_mb 20
        set -l suffix discord
        if set -q _flag_size
            set target_mb $_flag_size
            set -l pretty (math -s 4 $target_mb)
            set pretty (string trim --right --chars=0 -- $pretty)
            set pretty (string trim --right --chars=. -- $pretty)
            set suffix $pretty"mb"
        end

        set -l duration (ffprobe -v error -show_entries format=duration -of csv=p=0 -- $file)
        if test -z "$duration"
            echo "Processing failed. Could not read duration." >&2
            return 1
        end

        set -l audio_kbps 96
        set -q _flag_no_audio
        and set audio_kbps 0
        set -l total (math "($target_mb * 1024 * 8 / $duration) * 0.95")
        set -l video_kbps (math -s 0 "max(100, $total - $audio_kbps)")

        echo "Video duration: "(math -s 1 $duration)"s"
        echo "Target: "$target_mb"MB → Video bitrate: "$video_kbps"kbps"

        set -l filters
        if set -q _flag_taskbar
            set -a filters crop=in_w:in_h-75:0:75
        end
        if test $video_kbps -lt 500
            set -a filters scale=640:-2
        else if test $video_kbps -lt 1000
            set -a filters scale=854:-2
        else if test $video_kbps -lt 2000
            set -a filters scale=1280:-2
        end

        set -l vf
        if test (count $filters) -gt 0
            set vf -vf (string join , $filters)
        end

        set -l ext (path extension $file)
        set -l stem (path change-extension '' $file)
        set -l out "$stem-$suffix$ext"

        echo "Pass 1/2..."
        ffmpeg -y -i $file -c:v libx264 -b:v {$video_kbps}k -preset slow -pass 1 -an $vf -f null /dev/null
        or begin
            echo "Processing failed. Error: ffmpeg pass 1 failed" >&2
            return 1
        end

        echo "Pass 2/2..."
        if set -q _flag_no_audio
            ffmpeg -y -i $file -c:v libx264 -b:v {$video_kbps}k -preset slow -pass 2 $vf -an $out
        else
            ffmpeg -y -i $file -c:v libx264 -b:v {$video_kbps}k -preset slow -pass 2 $vf -c:a aac -b:a {$audio_kbps}k -ac 2 $out
        end
        or begin
            echo "Processing failed. Error: ffmpeg pass 2 failed" >&2
            return 1
        end

        rm -f ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree
        set -l bytes (stat -f %z $out)
        set -l mb (math -s 2 "$bytes / 1048576")
        set -l shown (string replace --all ' ' '\\ ' -- $out)
        echo "Done! Output: $shown ("$mb"MB)"
        return 0
    end

    if set -q _flag_mp3
        set -l out (path change-extension .mp3 $file)
        ffmpeg -i $file $out
        or begin
            echo "Processing failed. Error: ffmpeg failed" >&2
            return 1
        end
        set -l shown (string replace --all ' ' '\\ ' -- $out)
        echo "File processed successfully. Output file: $shown"
        return 0
    end

    set -l ext (path extension $file)
    set -l stem (path change-extension '' $file)
    set -l out "$stem-compressed$ext"

    set -l filters
    if set -q _flag_taskbar
        set -a filters crop=in_w:in_h-75:0:75
    end
    if set -q _flag_tiny
        set -a filters scale=480:-1
    end

    set -l vf
    if test (count $filters) -gt 0
        set vf -vf (string join , $filters)
    end

    if set -q _flag_no_audio
        ffmpeg -i $file -vcodec libx264 -crf 28 -preset fast -an $vf $out
    else if set -q _flag_tiny
        ffmpeg -i $file -vcodec libx264 -crf 28 -preset fast -acodec aac -b:a 96k -ar 44100 -ac 1 $vf $out
    else
        ffmpeg -i $file -vcodec libx264 -crf 28 -preset fast -acodec aac -b:a 128k -ar 44100 -ac 2 $vf $out
    end
    or begin
        echo "Processing failed. Error: ffmpeg failed" >&2
        return 1
    end

    set -l shown (string replace --all ' ' '\\ ' -- $out)
    echo "File processed successfully. Output file: $shown"
end
