# ls various configurations

if command -v eza > /dev/null; then
  alias ls='eza --sort=type --icons=always'
  alias ll='eza --sort=type --icons=always -AlhF'
  alias la='eza --sort=type --icons=always -AF'
  alias l='eza --sort=type --icons=always -F'
else
  alias ls='ls --sort=extension'
  alias ll='ls --sort=extension -Alh'
  alias la='ls --sort=extension -A'
  alias l='ls --sort=extension'
fi

