function adpush --description 'Push an image or video to /sdcard/Pictures and scan it into the gallery'
    if test (count $argv) -ne 1
        echo "Usage: adpush <file>" >&2
        return 1
    end

    set -l src $argv[1]
    if not test -f $src
        echo "File not found: $src" >&2
        return 1
    end

    set -l name (uuidgen | string lower)(path extension $src)
    set -l dest /sdcard/Pictures/$name

    adb push $src $dest
    or return

    adb shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file://$dest
end
