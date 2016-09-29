#! /bin/zsh

##########################
# Requirements
#########################

# git clone https://github.com/zsh-users/antigen.git
# gem install tmuxinator - tmux session configuration
# brew install grc - colouring terminal output
# brew install zsh-syntax-highlighting - highlighting commands
# brew install terminal-notifier - mac notification centre from terminal

##########################
# General Setup
#########################

# Tmuxinator auto-complete
export ZSH_TMUX_AUTOSTART=true

# Antigen
source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh

# Load plugins
antigen bundle bower
antigen bundle brew
antigen bundle brew-cask
antigen bundle capistrano
antigen bundle composer
antigen bundle command-not-found
antigen bundle dirhistory
antigen bundle extract
antigen bundle git
antigen bundle git-flow
antigen bundle grunt
antigen bundle laravel5
antigen bundle man
antigen bundle node
antigen bundle npm
antigen bundle rsync
antigen bundle safe-paste
antigen bundle thefuck
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle vagrant
antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src

antigen bundle smallhadroncollider/antigen-skeleton
antigen bundle smallhadroncollider/antigen-git-rebase

antigen theme bhilburn/powerlevel9k powerlevel9k

# Apply antigen
antigen apply

# Custom commands
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-functions"

# User direnv
eval "$(direnv hook zsh)"

# Set key timeout to 1ms for zsh vimode
export KEYTIMEOUT=1

# Bind the § key to run thefuck
bindkey "§" fuck-command-line

# Theme Settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="> "
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode time)
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_DIR_HOME_BACKGROUND='magenta'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='magenta'
POWERLEVEL9K_VCS_BACKGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_TIME_BACKGROUND='blue'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='red'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='cyan'

# Use z
. `brew --prefix`/etc/profile.d/z.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
