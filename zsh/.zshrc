#  _____  _____ __  ______  ______   __________  _   __________________
# /__  / / ___// / / / __ \/ ____/  / ____/ __ \/ | / / ____/  _/ ____/
#   / /  \__ \/ /_/ / /_/ / /      / /   / / / /  |/ / /_   / // / __
#  / /_____/ / __  / _, _/ /___   / /___/ /_/ / /|  / __/ _/ // /_/ /
# /____/____/_/ /_/_/ |_|\____/   \____/\____/_/ |_/_/   /___/\____/

# insert mode by default
MODE="ins"
MODE_COLOR='%F{159}' # bright blue for insert mode

# deactivate bell and confirmation for rm command
setopt NO_BEEP
setopt rmstarsilent

# enable color support (zsh)
if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# opencode
export PATH=/home/erick/.opencode/bin:$PATH
