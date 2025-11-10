#!/usr/bin/env bash

# Ensure it's executable:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# DEFAULT_ICONS=(":code:" ":discord:" ":spotify:" ":arc:")
FOCUSED_WORKSPACE=$(hyprspace list-workspaces --focused)

update_workspace_icon() {
    local workspace_id=$1

    local APP_ICONS=$(hyprspace list-windows --workspace $workspace_id |
        awk -F '|' '{print $2}' |
        while read -r app_name; do
            $CONFIG_DIR/plugins/icon_map_fn.sh "$app_name"
        done | tr '\n' ' ')

    if [ -z "$APP_ICONS" ]; then
        APP_ICONS="⏺︎"
    fi

    if [ "$workspace_id" == "$FOCUSED_WORKSPACE" ]; then
        sketchybar --set $NAME label="$APP_ICONS" background.drawing=on
    else
        sketchybar --set $NAME label="$APP_ICONS" background.drawing=off
    fi
}

update_workspace_icon $1
