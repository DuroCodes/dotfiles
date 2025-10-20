#!/bin/bash

INDEX=0
ALL_WORKSPACES=$(aerospace list-workspaces --all)

for sid in $ALL_WORKSPACES; do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change front_app_switched \
    --set space.$sid \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=20 \
    background.drawing=off \
    icon.padding_left=0 \
    icon.padding_right=0 \
    label.padding_left=3 \
    label.padding_right=3 \
    label.font="sketchybar-app-font:Regular:16.0" \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"

  if [[ $sid != $(echo "$ALL_WORKSPACES" | tail -n1) ]]; then
    sketchybar --add item space_separator.$sid left \
      --set space_separator.$sid \
      icon="" \
      icon.color=0xffc9c7cd \
      icon.padding_left=8 \
      icon.font="CaskaydiaCove Nerd Font Mono:Regular:20.0" \
      label.drawing=off
  fi

  INDEX=$((INDEX + 1))
done
