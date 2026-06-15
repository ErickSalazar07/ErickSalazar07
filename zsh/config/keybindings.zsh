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
