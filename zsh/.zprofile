# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/chanwutk/.docker/bin"
# End of Docker Desktop section.

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# >>> Codex installer >>>
export PATH="/Users/chanwutk/.local/bin:$PATH"
# <<< Codex installer <<<

source $HOME/.config/profile.sh
