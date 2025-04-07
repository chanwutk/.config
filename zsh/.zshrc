source $HOME/.config/rc.sh

source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source $HOME/.config/zsh/plugins/gitstatus/gitstatus.prompt.zsh
# PROMPT="%4~ $GITSTATUS_PROMPT %# "
# RPROMPT="$GITSTATUS_PROMPT"
source $HOME/.config/zsh/plugins/gitstatus/gitstatus.plugin.zsh

function my_set_prompt() {
  PROMPT='%~ %# '
  RPROMPT=''

  if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
    RPROMPT=${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}  # escape %
    (( VCS_STATUS_NUM_STAGED    )) && RPROMPT+='+'
    (( VCS_STATUS_NUM_UNSTAGED  )) && RPROMPT+='!'
    (( VCS_STATUS_NUM_UNTRACKED )) && RPROMPT+='?'
  fi

  setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook precmd my_set_prompt
