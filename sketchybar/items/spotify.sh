#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"

sketchybar --add event spotify_change $SPOTIFY_EVENT \
  --add item spotify right \
  --set spotify \
  icon.padding_left=0 \
  icon= \
  background.drawing=off \
  script="$PLUGIN_DIR/spotify.sh" \
  --subscribe spotify spotify_change
