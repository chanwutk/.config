# Prompt ----------------------------------------------------------------------
if [ -n "${ZSH_VERSION:-}" ]; then
  setopt PROMPT_SUBST
  PROMPT='%n@%m:%F{blue}%~%f %# '
elif [ -n "${BASH_VERSION:-}" ]; then
  __prompt_command() {
    PS1='\u@\h:\[\033[01;34m\]\w\[\033[00m\]'
  }
  PROMPT_COMMAND=__prompt_command
fi

# Cargo -----------------------------------------------------------------------
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
if [ -f "$CARGO_HOME/env" ]; then
  . "$CARGO_HOME/env"
fi


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
# if command -v nvim &> /dev/null; then
#   alias vim=nvim
# fi

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
if command -v fzf >/dev/null 2>&1; then
  if [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(fzf --zsh)"
    [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh" ] &&
      source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
  elif [ -n "${BASH_VERSION:-}" ]; then
    eval "$(fzf --bash)"
    [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash" ] &&
      source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash"
  fi
fi

# fnm -------------------------------------------------------------------------
if which fnm &>/dev/null; then
  eval "`fnm env`"
fi

# Autoenv ---------------------------------------------------------------------
if [ -d $XDG_DATA_HOME/autoenv ]; then
  source $XDG_DATA_HOME/autoenv/activate.sh
fi
