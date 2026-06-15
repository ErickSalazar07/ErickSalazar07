# enviroment variables for configuration, history files, etc


# XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"

# python variables
export PYTHONSTARTUP="/etc/python3/pythonrc.py"

# adds ~/.local/bin to $PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
[[ ":$PATH:" != *":/opt/nvim-linux-x86_64/bin:"* ]] && export PATH="/opt/nvim-linux-x86_64/bin:$PATH"

# configures custom config files for programs
# export VIMINIT='source $HOME/.config/vim/vimrc'

# default programs
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"

# vim as manpager
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"
