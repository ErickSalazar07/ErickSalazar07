
# style and formatting for git
zstyle ':vcs_info:git:*' formats ' -%F{141} ( %b)%f'
zstyle ':vcs_info:*' enable git
autoload -Uz vcs_info
setopt prompt_subst

