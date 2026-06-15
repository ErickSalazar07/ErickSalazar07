# set up fzf key bindings and fuzzy completion
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh


# style for fzf
export FZF_DEFAULT_OPTS='--layout=reverse --border=bold --border=rounded --margin=3% --color=dark'


fzf_files_from_home() {
  find "$HOME" \
    \( -name snap -o \
      -name .vscode -o \
      -path "$HOME/.config/Code" -o \
      -path "$HOME/.nvim" -o \
      -name .npm -o \
      -name .nvm -o \
      -name .cache -o \
      -name node_modules -o \
      -name .gnupg -o \
      -name .git -o \
      -name .ssh \) -prune -o \
    -type f -print 2>/dev/null |
  fzf \
    --multi \
    --height=100% \
    --preview '
      if [ -d {} ]; then
        ls -lah {}
      elif file --mime {} | grep -q text; then
        batcat --style=numbers --color=always --line-range :500 {}
      else
        file {}
      fi
    ' \
    --preview-window=right:60%:wrap
}

fzf_files_home_widget() {
  local file
  file=$(fzf_files_from_home) || return
  LBUFFER+="$file"
}

zle -N fzf_files_home_widget

# Ctrl+I -> home (ojo: esto normalmente pisa TAB)
bindkey '^F' fzf_files_home_widget

# ctrl + K for directorys
fzf_dirs_from_home() {
  find "$HOME" \
    \( -name snap -o \
      -name .vscode -o \
      -path "$HOME/.config/Code" -o \
      -path "$HOME/.nvim" -o \
      -name .npm -o \
      -name .nvm -o \
      -name .cache -o \
      -name node_modules -o \
      -name .gnupg -o \
      -name .git -o \
      -name .ssh \) -prune -o \
    -type d -print 2>/dev/null |
  fzf \
    --height=100% \
    --preview 'ls -lah {}' \
    --preview-window=right:60%
}

fzf_dirs_widget() {
  local dir
  dir=$(fzf_dirs_from_home) || return
  LBUFFER+="$dir"
}

zle -N fzf_dirs_widget

bindkey '^K' fzf_dirs_widget


