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
source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh

# Load plugins
antigen bundle bower
antigen bundle brew
antigen bundle extract
antigen bundle git
antigen bundle laravel
antigen bundle node
antigen bundle npm
antigen bundle rsync
antigen bundle safe-paste
antigen bundle sublime
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle vagrant
antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src

antigen bundle smallhadroncollider/skeleton

# Set theme
antigen theme smallhadroncollider/zsh-theme smallhadron

# Apply antigen
antigen apply

# Custom commands
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-functions"

# Set key timeout to 1ms for zsh vimode
export KEYTIMEOUT=1
