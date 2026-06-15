# zsh completion configuration file

# case sensitive completion
CASE_SENSITIVE="true"

# basic auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

