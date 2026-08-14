# -----------------------------------------------------------------------------
# FZF
# -----------------------------------------------------------------------------

source /usr/share/doc/fzf/examples/completion.zsh

# -----------------------------------------------------------------------------
# Apariencia
# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS="
--layout=reverse
--border=rounded
--border=bold
--margin=3%
--color=dark
"

# -----------------------------------------------------------------------------
# Ctrl + T
# Buscar archivos del proyecto actual
# Respeta .gitignore automáticamente
# -----------------------------------------------------------------------------

export FZF_CTRL_T_COMMAND='fdfind --type f --hidden --exclude .git'

# -----------------------------------------------------------------------------
# Exclusiones para búsquedas en $HOME
# -----------------------------------------------------------------------------

typeset -ga FZF_HOME_EXCLUDES=(
  snap
  .vscode
  .config/Code
  .nvim
  .npm
  .nvm
  .cache
  node_modules
  .gnupg
  .git
  .ssh
)

# -----------------------------------------------------------------------------
# Construye argumentos --exclude para fdfind
# -----------------------------------------------------------------------------

_fzf_home_fd_args() {
  local args=()

  for dir in "${FZF_HOME_EXCLUDES[@]}"; do
    args+=(--exclude "$dir")
  done

  printf '%s\n' "${args[@]}"
}

# -----------------------------------------------------------------------------
# Preview común
# -----------------------------------------------------------------------------

_fzf_preview='
if [ -d {} ]; then
  ls -lah {}
elif file --mime "{}" | grep -q text; then
  batcat --style=numbers --color=always --line-range=:500 "{}"
else
  file "{}"
fi
'

# -----------------------------------------------------------------------------
# Wrapper común
# -----------------------------------------------------------------------------

_fzf() {
  fzf \
    --height=100% \
    --multi \
    --preview "$_fzf_preview" \
    --preview-window=right:60%:wrap
}

# -----------------------------------------------------------------------------
# Ctrl + F
# Buscar archivos dentro del HOME
# -----------------------------------------------------------------------------

fzf_files_from_home() {
  local args=(
    --type f
    --hidden
  )

  while read -r arg; do
    args+=("$arg")
  done < <(_fzf_home_fd_args)

  fdfind "${args[@]}" . "$HOME" | _fzf
}

fzf_files_home_widget() {
  local file

  file=$(fzf_files_from_home) || return

  LBUFFER+="$file"
}

zle -N fzf_files_home_widget

bindkey '^F' fzf_files_home_widget

# -----------------------------------------------------------------------------
# Ctrl + K
# Buscar directorios dentro del HOME
# -----------------------------------------------------------------------------

fzf_dirs_from_home() {
  local args=(
    --type d
    --hidden
  )

  while read -r arg; do
    args+=("$arg")
  done < <(_fzf_home_fd_args)

  fdfind "${args[@]}" . "$HOME" |
  fzf \
    --height=100% \
    --preview 'ls -lah "{}"' \
    --preview-window=right:60%
}

fzf_dirs_widget() {
  local dir

  dir=$(fzf_dirs_from_home) || return

  LBUFFER+="$dir"
}

zle -N fzf_dirs_widget

bindkey '^K' fzf_dirs_widget

# -----------------------------------------------------------------------------
# Keybindings oficiales
# -----------------------------------------------------------------------------

source /usr/share/doc/fzf/examples/key-bindings.zsh
