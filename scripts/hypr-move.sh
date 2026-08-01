#!/bin/zsh

DIRECTION=$1

move_hypr () {
  hyprctl eval "hl.dispatch(hl.dsp.focus({ direction = \"$DIRECTION\" }))"
  exit
}

get_window_attr () {
  hyprctl activewindow | awk -F "$1: " '$2 {print $2}'
}

send_nav () {
  hyprctl eval "hl.dispatch(hl.dsp.send_shortcut({ mods = \"CTRL\", key = \"$1\", window = \"pid:$2\" }))"
}

WIN_CLASS=$(get_window_attr "class")
if [[ "$WIN_CLASS" != "kitty" ]]; then
  move_hypr
fi

TITLE=$(get_window_attr "title")
if [[ "$TITLE" != *nvim* && "$TITLE" != *:*:* ]]; then
  move_hypr 
fi

WIN_PID=$(get_window_attr "pid")

case $DIRECTION in
  l)
    send_nav H $WIN_PID
    ;;
  r)
    send_nav L $WIN_PID
    ;;
  u)
    send_nav K $WIN_PID
    ;;
  d)
    send_nav J $WIN_PID
    ;;
esac

