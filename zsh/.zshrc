source $HOME/.config/rc.sh
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/chanwutk/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /Users/chanwutk/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/chanwutk/zsh-autosuggestions/zsh-autosuggestions.zsh
