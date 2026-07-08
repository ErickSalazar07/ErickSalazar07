# eza various configurations and aliases

if command -v eza >/dev/null; then
  EZA_OPTS="--icons=always --group-directories-first --sort=extension -F"
  alias ls="eza $EZA_OPTS"
  alias l="eza $EZA_OPTS"
  alias la="eza $EZA_OPTS -A"
  alias ll="eza $EZA_OPTS -Alh --git"
  alias tree="eza $EZA_OPTS --tree -r"
else
  alias ls='ls --group-directories-first --sort=extension'
  alias l='ls -F --group-directories-first --sort=extension'
  alias la='ls -AF --group-directories-first --sort=extension'
  alias ll='ls -AlhF --group-directories-first --sort=extension'
fi
