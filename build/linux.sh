#! /bin/env bash

set -e # if there is an error, exits the building script (See specifics of set -e)


# ---------- utils SECTION ----------
C_RST='\033[0m' # Color ReSeT
C_R='\033[31m' # Color Red
C_G='\033[32m' # Color Green
C_Y='\033[33m' # Color Yellow
C_B='\033[34m' # Color Blue

EXIT_SUCCESS=0
EXIT_FAILURE=1


msgError() {
  local msg="$1"
  printf "${C_R}ERROR:${C_RST} %b.\n" "$msg"
}


# ---------- zsh BUILDING FUNCTION ----------
buildZsh() {
  local pRoot="$1"

  local zshEnvP='/etc/zsh/zshenv' # path to the general zsh environment file (with the only purpose of setting the basic config)
  local zshCacheDir="$HOME/.cache/zsh" # path to the cache directory for zsh
  local zshConfDir="$HOME/.config/zsh" # path to the config directory for zsh
  local localZshConfDir="$pRoot/zsh" # path to the local config directory for zsh

  if ! command -v zsh > /dev/null; then
    msgError "Can't find ${C_B}zsh${C_RST} program, install it before running this script"
    exit $EXIT_FAILURE
  fi

  if [ -e "$zshEnvP" ]; then
    printf "[[ -z \"\$ZDOTDIR\" ]] && export ZDOTDIR=\"$zshConfDir\"\n" >> "$zshEnvP"
  else
    msgError "$zshEnvP file does not exists"
    exit $EXIT_FAILURE
  fi

  mkdir -p "$zshCacheDir" "$zshConfDir" # creating directories for zsh

  for file in "$localZshConfDir"/*; do
    if [ -d "$file" ]; then
      cp -r "$file" "$zshConfDir/"
    else
      cp "$file" "$zshConfDir/$(basename $"file")"
    fi
  done

}


# ---------- tmux BUILDING FUNCTION ----------
buildTmux() {
  local pRoot="$1"

  local tmuxConfDir="$HOME/.config/tmux" # path to config directory for tmux
  local localTmuxConfDir="$pRoot/tmux" # path to local config directory for tmux

  if ! command -v tmux > /dev/null; then
    msgError "Can't find ${C_B}tmux${C_RST} program, install it before running this script"
    exit $EXIT_FAILURE
  fi

  mkdir -p "$tmuxConfDir"

  for file in "$localTmuxConfDir"/*; do
    cp "$file" "$tmuxConfDir/$(basename $"file")"
  done

}


# ---------- git BUILDING FUNCTION ----------
buildGit() {
  local pRoot="$1"

  local gitConfDir="$HOME/.config/git" # path to config directory for git
  local localGitConfDir="$pRoot/git" # path to local config directory for git

  if ! command -v git > /dev/null; then
    msgError "Can't find ${C_B}git${C_RST} program, install it before running this script"
    exit $EXIT_FAILURE
  fi

  mkdir -p "$gitConfDir"

  for file in "$localGitConfDir"/*; do
    cp "$file" "$gitConfDir/$(basename $"file")"
  done

}


# ---------- nvim (neovim) BUILDING FUNCTION ----------
buildNvim() {
  local pRoot="$1"

  local nvimConfDir="$HOME/.config/nvim" # path to config directory for nvim (neovim)
  local localNvimConfDir="$pRoot/nvim" # path to local config directory for nvim (neovim)

  if ! command -v nvim > /dev/null; then
    msgError "Can't find ${C_B}nvim (neovim)${C_RST} program, install it before running this script"
    exit $EXIT_FAILURE
  fi

  mkdir -p "$nvimConfDir"

  for file in "$localNvimConfDir"/*; do
    if [ -d "$file" ]; then
      cp -r "$file" "$nvimConfDir/"
    else
      cp "$file" "$nvimConfDir/$(basename $"file")"
    fi
  done

}


main() {

# ---------- minimum information - early returns SECTION ----------
  [ -z "$HOME" ] && msgError "\$HOME variable is not set" && exit $EXIT_FAILURE

  if ! uname -a | grep -iq 'linux'; then
    msgError "This is not a ${C_Y}Linux${C_RST} system, can't build user config"
    exit $EXIT_FAILURE
  fi


  local pRoot='../' # path to the project's root

  buildZsh "$pRoot"
  buildTmux "$pRoot"
  buildGit "$pRoot"
  buildNvim "$pRoot"

  exit $EXIT_SUCCESS
}

main "$@"
