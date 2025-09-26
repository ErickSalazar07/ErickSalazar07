#  _____  _____ __  ______  ______   __________  _   __________________
# /__  / / ___// / / / __ \/ ____/  / ____/ __ \/ | / / ____/  _/ ____/
#   / /  \__ \/ /_/ / /_/ / /      / /   / / / /  |/ / /_   / // / __  
#  / /_____/ / __  / _, _/ /___   / /___/ /_/ / /|  / __/ _/ // /_/ /  
# /____/____/_/ /_/_/ |_|\____/   \____/\____/_/ |_/_/   /___/\____/   
                                                                     

# source aliases
source $ZDOTDIR/aliases.zsh

# history commands
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt share_history


# style and formatting for git
zstyle ':vcs_info:git:*' formats ' -%F{208} ( %b)%f%k'
zstyle ':vcs_info:*' enable git
autoload -Uz vcs_info
setopt prompt_subst


# basic auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files


# vim mode for keybindings
bindkey -v
export KEYTIMEOUT=1

# vim keys in tab completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# key bindings in vim-insert-mode for going up and down in line history 
bindkey -v '^p' up-line-or-history
bindkey -v '^n' down-line-or-history


# insert mode by default
MODE="ins"
MODE_COLOR='%F{159}' # bright blue for insert mode


# change cursor shape for differente vim modes
function zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]]; then
    MODE="norm"
    MODE_COLOR='%F{245}' # purple for normal mode
  else
    MODE="ins"
    MODE_COLOR='%F{159}' # bright blue for insert mode
  fi
  zle reset-prompt
}
zle -N zle-keymap-select


# runs in insert mode
zle-line-init() {
  zle -K viins
  MODE="ins"
  MODE_COLOR='%F{159}'
  echo -ne '\e[2 q'
  zle reset-prompt
}
zle -N zle-line-init


# builds dynamic prompt
precmd() { vcs_info }

PROMPT='%F{green}%n%f@%F{blue}%m%f(${MODE_COLOR}${MODE}%f)${vcs_info_msg_0_}%F{white}$ %f'

# edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


# deactivate bell and confirmation for rm command
setopt NO_BEEP 
setopt rmstarsilent


# case sensitive completion
CASE_SENSITIVE="true"


# loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# function for opening various types of files or directories
function open() {
  files=("$@") # array of files
  for file in "${files[@]}"; do
    xdg-open "$file"
  done
}

