
#  _____  _____ __  ______  ______   __________  _   __________________
# /__  / / ___// / / / __ \/ ____/  / ____/ __ \/ | / / ____/  _/ ____/
#   / /  \__ \/ /_/ / /_/ / /      / /   / / / /  |/ / /_   / // / __  
#  / /_____/ / __  / _, _/ /___   / /___/ /_/ / /|  / __/ _/ // /_/ /  
# /____/____/_/ /_/_/ |_|\____/   \____/\____/_/ |_/_/   /___/\____/   
                                                                     


export ZSH="$HOME/.oh-my-zsh" # path to your Oh My Zsh installation.
export PATH="$HOME/.local/bin:$HOME/.local/bin/kotlinc/bin:$PATH" # load personal paths
export MANROFFOPT='-c'
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'" # set default man pager to 'bat'

ZSH_THEME="" # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes



CASE_SENSITIVE="true" # set to "true" to use case-sensitive completion.


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh

setopt NO_BEEP # deactivate bell or beep 
setopt rmstarsilent # deactivate confirmation for rm command

autoload -Uz vcs_info # custom simple prompt with git

zstyle ':vcs_info:git:*' formats '%F{208} ( %b)%f%k'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
}

PROMPT='%F{green}%n%f@%F{blue}%m%f${vcs_info_msg_0_}%F{white}$ %f'
