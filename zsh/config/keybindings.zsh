# keybindings configuration file -- Vim mode is used for zsh interaction

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

# edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

