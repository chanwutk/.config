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
if command -v nvim &> /dev/null; then
  alias vim=nvim
fi


# fzf -------------------------------------------------------------------------
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash


# fnm -------------------------------------------------------------------------
if which fnm &>/dev/null; then
  eval "`fnm env`"
fi


# Autoenv ---------------------------------------------------------------------
if [ -d $XDG_DATA_HOME/autoenv ]; then
  source $XDG_DATA_HOME/autoenv/activate.sh
fi
