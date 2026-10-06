function reload --description 'Restart AeroSpace and reload sketchybar'
    pkill AeroSpace
    open -a AeroSpace
    sketchybar --reload
end
