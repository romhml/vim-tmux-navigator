#!/usr/bin/env bash
direction="$1" # left, right, top, bottom
hypr_dir="$2"  # l, r, u, d

# Check if we're at the edge in this direction
tmux_var="#{pane_at_${direction}}"
if [[ "$(tmux display-message -p $tmux_var)" == "1" ]]; then
  if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
    hyprctl eval "hl.dispatch(hl.dsp.focus({ direction = \"$direction\" }))" > /dev/null
    exit
  fi
fi

# Normal tmux navigation
tmux select-pane -"${hypr_dir^^}"
