
# builds dynamic prompt
precmd() { vcs_info }

PROMPT='%F{75}%n%f@%F{208}ubuntu%f(${MODE_COLOR}${MODE}%f)${vcs_info_msg_0_}%F{white}$ %f'

