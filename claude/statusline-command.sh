#!/bin/bash
# Status line: model, effort level, and remaining usage for the 5h / weekly windows.
# The "|" marker inside each bar is where time-remaining sits, so usage ahead of
# the marker means you're burning quota faster than the window refills.

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // "?"')
model=${model/ (1M context)/ 1M}
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')

read -r five_used five_reset <<<"$(printf '%s' "$input" | jq -r '[.rate_limits.five_hour.used_percentage // "", .rate_limits.five_hour.resets_at // ""] | join(" ")')"
read -r week_used week_reset <<<"$(printf '%s' "$input" | jq -r '[.rate_limits.seven_day.used_percentage // "", .rate_limits.seven_day.resets_at // ""] | join(" ")')"

now=$(date +%s)

# gauge <label> <used-percent> <resets-at-epoch> <window-seconds>
gauge() {
  awk -v label="$1" -v used="$2" -v reset="$3" -v window="$4" -v now="$now" 'BEGIN {
    if (used == "") {
      printf "%s \033[90m--------------------\033[0m", label
      exit
    }

    left = 100 - used
    if (left < 0) left = 0
    filled = int(left / 5 + 0.5)

    mark = -1
    if (reset != "") {
      secs = reset - now
      if (secs < 0) secs = 0
      mark = int(secs / window * 20 + 0.5) - 1
      if (mark < 0) mark = 0
      if (mark > 19) mark = 19
    }

    color = left > 50 ? 32 : (left > 20 ? 33 : 31)
    bar = ""
    for (i = 0; i < 20; i++) {
      if (i == mark) bar = bar "\033[97m|\033[" color "m"
      else bar = bar (i < filled ? "\342\226\210" : "\342\226\221")
    }
    printf "%s \033[%dm%s\033[0m", label, color, bar
  }'
}

label="$model"
[ -n "$effort" ] && label="$label $effort"

printf '\033[36m%s\033[0m  ' "$label"
gauge "5h" "$five_used" "$five_reset" 18000
printf '  '
gauge "wk" "$week_used" "$week_reset" 604800
