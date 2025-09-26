#!/bin/sh

# output colors
c_rst='\033[0m'
c_red='\033[31m'
c_green='\033[32m'
c_yellow='\033[33m'
c_blue='\033[34m'

conf_d="$HOME/.config" # .config directory
cache_d="$HOME/.cache" # .cache directory
dotf_d='../dotfiles' # dotfiles directory within the repository

printf '%sconfigurating:%s\n\n' "$c_yellow" "$c_rst"

printf '%s-%s dotfiles:\n' "$c_blue" "$c_rst"
# config zsh directory
[ ! -d "$conf_d/zsh" ] && mkdir "$conf_d/zsh" && cp "$dotf_d/.zshrc" "$dotf_d/aliases.zsh" "$conf_d/zsh/"

# config vim directory
[ ! -d "$conf_d/vim" ] && mkdir "$conf_d/vim" && cp "$dotf_d/vimrc" "$conf_d/vim/"

# config tmux directory
[ ! -d "$conf_d/tmux" ] && mkdir "$conf_d/tmux" && cp "$dotf_d/tmux.conf" "$conf_d/tmux/"


# configures cache files a.k.a history/info files/directorys

printf '%s-%s cache:\n' "$c_blue" "$c_rst"
# cache zsh
[ ! -d "$cache_d/zsh" ] && mkdir "$cache_d/zsh"

# cache vim
[ ! -d "$cache_d/vim" ] && mkdir "$cache_d/vim"

printf '%sconfiguration success%s\n' "$c_green" "$c_rst"
