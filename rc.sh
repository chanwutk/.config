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

opencode() {
  # Loop over each port in the configured forwarding range
  for port in $(seq $VLLM_PORT_START $VLLM_PORT_END); do
    # Check if an SSH tunnel for this specific port to the VLLM host is already running
    if ! pgrep -f "ssh.*-L $port:localhost:$port.*$VLLM_HOST" &>/dev/null; then
      echo "Forwarding port $port -> $VLLM_HOST:$port"
      # Start the tunnel for this port in the background (-N: no remote command, -L: local port forwarding)
      ssh -N -L $port:localhost:$port chanwutk@$VLLM_HOST &
    else
      echo "Port $port already forwarded to $VLLM_HOST:$port"
    fi
  done
  # Run the real opencode binary (command builtin bypasses this function to avoid recursion)
  command opencode "$@"
}

claude_local() {
  local port=$VLLM_PORT_0
  # Check if an SSH tunnel for this specific port to the VLLM host is already running
  if ! pgrep -f "ssh.*-L $port:localhost:$port.*$VLLM_HOST" &>/dev/null; then
    echo "Forwarding port $port -> $VLLM_HOST:$port"
    # Start the tunnel for this port in the background (-N: no remote command, -L: local port forwarding)
    ssh -N -L $port:localhost:$port chanwutk@$VLLM_HOST &
  else
    echo "Port $port already forwarded to $VLLM_HOST:$port"
  fi

  # Set environment variables for Claude Code to use local vLLM
  # Requires: VLLM_LOCAL_URL (default: http://localhost:8000) and VLLM_MODEL env vars
  ANTHROPIC_BASE_URL=${VLLM_LOCAL_URL:-http://localhost:$port} \
  ANTHROPIC_API_KEY=${VLLM_API_KEY:-dummy} \
  ANTHROPIC_AUTH_TOKEN=${VLLM_API_KEY:-dummy} \
  ANTHROPIC_DEFAULT_OPUS_MODEL=${VLLM_MODEL:-kimi-k25-think} \
  ANTHROPIC_DEFAULT_SONNET_MODEL=${VLLM_MODEL:-kimi-k25-think} \
  ANTHROPIC_DEFAULT_HAIKU_MODEL=${VLLM_MODEL:-kimi-k25-think} \
  CLAUDE_CODE_ATTRIBUTION_HEADER=0 \
  command claude "$@"
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
