# bat various configurations

if command -v batcat > /dev/null; then
  alias b='batcat'
elif command -v bat > /dev/null; then
  alias b='bat'
else
  alias b='cat'
fi

