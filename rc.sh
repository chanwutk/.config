# Prompt ----------------------------------------------------------------------
# Generate a color based on the hash of user@hostname (using fast built-in bash hash)
if [[ "$OSTYPE" == "darwin"* ]]; then
  __HOST_COLOR=""
else
  __HOST_HASH=$(( $(printf '%s' "$USER@$HOSTNAME" | cksum | cut -d' ' -f1) ))
  # Colors that work well on both light and dark themes
  __HOST_COLORS=(33 34 35 36 37 38 94 130 166 172)
  __HOST_COLOR_CODE=${__HOST_COLORS[$((__HOST_HASH % ${#__HOST_COLORS[@]}))]}
  __HOST_COLOR="\[\033[38;5;${__HOST_COLOR_CODE}m\]"
fi

function __prompt_command {
  GREEN="\[\033[0;32m\]"
  BOLD_GREEN="\[\033[01;32m\]"
  CYAN="\[\033[0;36m\]"
  # RED="\[\033[0;31m\]"
  PURPLE="\[\033[0;35m\]"
  # BROWN="\[\033[0;33m\]"
  # BLUE="\[\033[0;34m\]"
  # LIGHT_OLIVE="\[\033[01;33m\]"
  # LIGHT_GRAY="\[\033[0;37m\]"
  # LIGHT_BLUE="\[\033[1;34m\]"
  # LIGHT_GREEN="\[\033[1;32m\]"
  # LIGHT_CYAN="\[\033[1;36m\]"
  # LIGHT_RED="\[\033[1;31m\]"
  # LIGHT_PURPLE="\[\033[1;35m\]"
  # YELLOW="\[\033[1;33m\]"
  # WHITE="\[\033[1;37m\]"
  RESTORE="\[\033[0m\]" #0m restores to the terminal's default colour
  # BRANCH=""
  # if which git &>/dev/null; then
    BRANCH="$(git branch 2>/dev/null | grep \* | cut -d ' ' -f 2-)"
  # else
  #   BRANCH="(git not installed)"
  # fi
  
  PS1='${debian_chroot:+($debian_chroot)}'"${__HOST_COLOR}"'\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
  # PS1="${BOLD_GREEN}\h ${RESTORE}\w"
  # if [ -n "$BRANCH" ]; then
  #   PS1+=" ${CYAN}${BRANCH}${RESTORE}"
  # fi
  # RET=$?
  # if [[ $RET != 0 ]]; then
  #   ERRMSG=" $RET"
    # PS1+="${RED}${ERRMSG}"
  # fi
  # if [ -n "$CONDA_DEFAULT_ENV" ]; then
  #   PS1+=" ${PURPLE}($CONDA_DEFAULT_ENV)"
  # fi
  if [ -n "$CUDA_VISIBLE_DEVICES" ]; then
      PS1+=" (cuda:${CUDA_VISIBLE_DEVICES})"
  else
      PS1+=" (cuda:all)"
  fi
  # PS1+="\n\[\033[01;$((35+!$?))m\]>${RESTORE} "
  PS1+=" \$ "
}
# PROMPT_DIRTRIM=3
export PROMPT_COMMAND=__prompt_command

# Aliases ---------------------------------------------------------------------
if command -v eza &> /dev/null; then
  alias ls=eza
  alias lg='eza -laF --git'
  alias tree='eza --tree --long'
fi
if command -v bat &> /dev/null; then
  alias cat='bat -p'
fi
alias ll='ls -lahF'
alias sl='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'
alias vim='vim -i NONE'
if command -v nvim &> /dev/null; then
  alias vim=nvim
fi

# Functions -------------------------------------------------------------------
dock() {
  local docker_name
  if [ $# -eq 0 ]; then
    # Use current directory name if no argument provided
    docker_name=$(basename "$PWD")
  else
    # Use first argument if provided
    docker_name="$1"
  fi
  docker exec -it "$docker_name" bash
}

# fzf -------------------------------------------------------------------------
if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
fi

# fnm -------------------------------------------------------------------------
if which fnm &>/dev/null; then
  eval "`fnm env`"
fi

# Autoenv ---------------------------------------------------------------------
if [ -d $XDG_DATA_HOME/autoenv ]; then
  source $XDG_DATA_HOME/autoenv/activate.sh
fi
