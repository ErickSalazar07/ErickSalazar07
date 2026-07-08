setopt prompt_subst
autoload -Uz vcs_info # load vcs_info
zstyle ':vcs_info:*' enable git # enable Git support

# git prompt format
zstyle ':vcs_info:git:*' formats '%F{208}( %b)%f'
zstyle ':vcs_info:git:*' actionformats '%F{67}( %b|%a)%f'

# update vcs_info before displaying the prompt
precmd() {
    vcs_info
}

PROMPT='%(?.%F{29}.%F{124})➜%f %F{69}%1~%f%F{252}:%f${vcs_info_msg_0_}%F{252}$%f '
