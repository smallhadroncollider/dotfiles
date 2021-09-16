#! /bin/zsh

##########################
# Requirements
#########################

# brew install antigen
# gem install tmuxinator - tmux session configuration
# brew install grc - colouring terminal output
# brew install zsh-syntax-highlighting - highlighting commands
# brew install terminal-notifier - mac notification centre from terminal

##########################
# General Setup
#########################

# Load all ssh keys
ssh-add -A &>/dev/null

# Tmuxinator auto-complete
export ZSH_TMUX_AUTOSTART=true

# Antigen
source $(brew --prefix)/share/antigen/antigen.zsh

ANTIGEN_BUNDLES="$HOME/.antigen/bundles"

antigen use oh-my-zsh

# Load plugins
antigen bundle capistrano
antigen bundle command-not-found
antigen bundle dirhistory
antigen bundle docker
antigen bundle extract
antigen bundle git
antigen bundle git-flow
antigen bundle man
antigen bundle node
antigen bundle npm
antigen bundle rsync
antigen bundle rails
antigen bundle safe-paste
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle vagrant
antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen bundle smallhadroncollider/antigen-skeleton
antigen bundle smallhadroncollider/antigen-git-rebase
antigen bundle smallhadroncollider/antigen-watch
antigen bundle smallhadroncollider/antigen-format-git-commit

# Theme Settings
prompt_dirp () {
    local content=`pwd | sed -E -e "s,\/Volumes\/Projects\/mark\/?,  ,g" | sed -E -e "s,\/Users\/mark\/?,  ,g" | sed -E -e "s,\/Volumes\/Projects\/clients\/?,  ,g"`
    $1_prompt_segment "$0" "$2" "magenta" "black" "$content" "#"
}

POWERLEVEL9K_INSTALLATION_PATH="$ANTIGEN_BUNDLES/bhilburn/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="λ: "
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dirp vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode command_execution_time time)
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_VCS_BACKGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_TIME_BACKGROUND='blue'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='red'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='cyan'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='green'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

antigen theme bhilburn/powerlevel9k powerlevel9k

# Apply antigen
antigen apply

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore-case --hidden --follow --glob "!**/.git/*"'

# Custom commands
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-functions"

# User direnv
eval "$(direnv hook zsh)"

# Set key timeout to 1ms for zsh vimode
bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward
export KEYTIMEOUT=1
# Use z
. `brew --prefix`/etc/profile.d/z.sh

# iTerm integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# quick navigation
zle -N quick_find_widget quick_find
bindkey "^p" quick_find_widget
