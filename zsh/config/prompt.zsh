setopt prompt_subst
autoload -Uz vcs_info # load vcs_info

# enable git support and define git format
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{208}( %b)%f'
zstyle ':vcs_info:git:*' actionformats '%F{204}( %b|%a)%f'

# update vcs_info before displaying the prompt
precmd() {
    vcs_info
}

# ssh prompt
[[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && SSH_PROMPT='%F{222}(ssh)%f'

# main prompt
MAIN_PROMPT='%(?.%F{29}.%F{124})➜%f %F{69}%1~%f%F{252}:%f'

# ending prompt
END_PROMPT='%F{252}$%f'


PROMPT='${SSH_PROMPT}${MAIN_PROMPT}${vcs_info_msg_0_}${END_PROMPT} '
