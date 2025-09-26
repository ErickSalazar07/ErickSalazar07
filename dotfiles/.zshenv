# enviroment variables for configuration, history files, etc


# XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"


# adds ~/.local/bin to $PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# configures custom config files for programs
export VIMINIT='source $HOME/.config/vim/vimrc'
export TMUX_CONF="$XDG_CONFIG_HOME/tmux/tmux.conf"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


# configures history files for programs
export PYTHON_HISTORY="$XDG_CACHE_HOME/python/history"
export PSQL_HISTORY="$XDG_CACHE_HOME/psql/history"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node/repl_history"


# default programs
export EDITOR="gvim -v"
export BROWSER="firefox"


# colorized pages with bat
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"


# style for fzf
export FZF_DEFAULT_OPTS='--layout=reverse --border=bold --border=rounded --margin=3% --color=dark'
