# XDG -------------------------------------------------------------------------
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"


# Cleanup Home Directory ------------------------------------------------------

# cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# ipython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
# jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
# less
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
# node
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
# keras
export KERAS_HOME="${XDG_STATE_HOME}/keras"
# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# bash_history
export HISTFILE="${XDG_CACHE_HOME}/bash/history"
# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# ruby
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
# macos shell
export SHELL_SESSIONS_DISABLE=1
# autoenv
export AUTOENV_AUTH_FILE="$XDG_STATE_HOME"/autoenv/authorized_list
export AUTOENV_NOTAUTH_FILE="$XDG_STATE_HOME"/autoenv/not_authorized_list
export AUTOENV_ENABLE_LEAVE="t"

# wget
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
# yarn
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
# bitmonero
alias monerod="monerod --data-dir $XDG_DATA_HOME/bitmonero"


# Term Color ------------------------------------------------------------------
export TERM="xterm-256color"


# Local Binaries --------------------------------------------------------------
export PATH=$HOME/.local/bin:$PATH
if [ -d "/usr/local/sbin" ] then
  export PATH="/usr/local/sbin:$PATH"
fi


# Local Libaries --------------------------------------------------------------
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib
export LIB_PATH=$HOME/.local


# Flags -----------------------------------------------------------------------
export CFLAGS=-I${LIB_PATH}/include
export LDFLAGS=-L${LIB_PATH}/lib


# Locale ----------------------------------------------------------------------
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_ALL="en_US.UTF-8"

