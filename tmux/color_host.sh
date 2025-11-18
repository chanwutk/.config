#!/bin/bash
# Display hostname with color based on user@hostname hash

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "#h"
else
  __HOST_HASH=$(( $(printf '%s' "$USER@$HOSTNAME" | cksum | cut -d' ' -f1) ))
  # Colors that work well on both light and dark themes
  __HOST_COLORS=(33 34 35 36 37 38 94 130 166 172)
  __HOST_COLOR_CODE=${__HOST_COLORS[$((__HOST_HASH % ${#__HOST_COLORS[@]}))]}
  printf "#[bg=colour%d,fg=black]%s#[default]" "$__HOST_COLOR_CODE" "$HOSTNAME"
fi
