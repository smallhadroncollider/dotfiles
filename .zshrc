##########################
# General Setup
#########################

# Tmuxinator auto-complete
source ~/.bin/tmuxinator.zsh
ZSH_TMUX_AUTOSTART=true

# Open grc on startup
source "$(brew --prefix)/etc/grc.bashrc"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE=true
ZSH_THEME="smallhadron"
plugins=(safe-paste git bower Composer npm tmux vagrant vi-mode brew z)
source "$ZSH/oh-my-zsh.sh"

# Set key timeout to 1ms
export KEYTIMEOUT=1


##########################
# Functions
#########################

# Log a file with mac notifications
# run `brew install terminal-notifier` to install terminal-notifier
logit () {
    tail -F $1 | while read line; do
        echo "$line" | sed $'s/$/\a/'
        echo "$line" | sed 's/[[:space:]]/\\ /g' | xargs -n 1 terminal-notifier -title $2 -message
    done
}

# Deletes a directory safely
rmdir () {
    echo -e '\nContents:'
    echo -e '=========\n'
    ls -AFG "$1"
    printf '\nAre you sure? (y/N): '
    read -r OPTION

    if [ "$OPTION" = 'y' -o "$OPTION" = 'yes' ]
        then rm -rf "$1"
        echo -e "\nDeleting $1...\n"
    fi
}

# Outputs the directory part of a path
dir () {
    echo "$1" | sed 's/[^\/]*$//'
}

# Touch, but creates directories if they don't exist
create () {
    dir=$(dir "$1")

    if [[ -n $dir && ! (-d $dir) ]]
        then mkdir -p "$dir"
        echo "Creating $dir"
    fi

    for i do
        \touch $i
    done
}

# Copy In Place: Copies file from directory to same directory
cpip () {
    dir=$(dir "$1")

    for i do
        if [[ $i != $1 ]]; then
            cp -v -n "$1" "$dir$i"
        fi
    done
}

# Move In Place: Moves file in directory to same directory
mvip () {
    dir=$(dir "$1")
    mv -n -v "$1" "$dir$2"
}

# Tmux Layout: displays the current Tmux window layout and adds it to the clipboard
layout () {
    tmux list-windows | awk '{print $7}' |  sed 's/\]$//' | pbcopy
    pbpaste
    echo '[tmux layout copied to clipboard]'
}

# Creates a new Tmux session from within an existing Tmux session
tnew () {
    if [[ $# -eq 1 ]]; then
        tmux new-session -d -s $1
        tmux switch-client -t $1
    else
        echo 'Session name required'
    fi
}

# Stops the current Tmux session and closes any Vagrant machines that might be running
stop () {
    vagrant halt 2> /dev/null
    tmux kill-session -t "$(tmux display-message -p '#S')"
}

# Runs a single command in Vagrant SSH
vssh () {
    command="$@"
    vagrant ssh -c "cd /vagrant; sudo $command"
}

# Finds a given filename in children directories
where() {
    find . -type f -name "*$1*" -not -path \*node_modules\* | sed 's/^\.\///'
}

# Commands
cmd() {
    echo "
    ^xx^yy      Replaces \`xx\` with \`yy\`
    !!          Get the previous command
    sudo !!     Run previous command with sudo
    !*          Gets all arguments from previous command
    !\$          Gets last argument from previous command
    !^          Gets first argument from previous command
    !1-4        Gets first four arguments from previous command
    !:-         Insert the last command without the last argument
    !?command   Get the last called version of command
    d           List previous directories
    1-9         Go to previous directories
    x           Extract files
    history     List previous commands
    !12         Execute command from history No 12
"
}

# Number of changed files in git commit
cfcount() {
    git diff-tree --no-commit-id --name-only -r $1 | wc -l
}

# Git rebase x number of stages back - 10 by default
rebase() {
    if [[ $# -eq 1 ]]; then
        git rebase -i HEAD~$1
    else
        git rebase -i HEAD~10
    fi
}

##########################
# Aliases
#########################

# Function aliases
alias tch="create"
alias touch="create"

# Shell aliases
alias mkdir="mkdir -p" # Create a directory recursively by default
alias here="open ./" # Open the cwd in Finder

# ZSH aliases
alias refresh="source ~/.zshenv; source ~/.zshrc" # Reload zsh settings
alias rc="subl ~/.zshrc"
alias path="subl ~/.zshenv"

# Sublime Text
alias st="subl ./"
alias snippets="subl ~/Dropbox/Application\ Files/Sublime\ Text\ 3/Packages/User/Snippets/"

# Apache
alias aprestart="sudo apachectl restart"
alias apconfig="subl /etc/apache2/httpd.conf"
alias aplog="less +F /var/log/apache2/error_log"

# PHP Aliases
alias phpini="subl /usr/local/etc/php/5.5/php.ini"
alias phplog="less +F /Users/mark/.php.log"
alias phpclr="cat /dev/null > /Users/mark/.php55.log"

# MySQL
alias db="mysql -u root --default-character-set=utf8 -D"

# Fuel PHP
alias oil-t="FUEL_ENV=test oil"
alias oil-d="FUEL_ENV=development oil"
alias oil-p="FUEL_ENV=production oil"

# Tmux aliases
alias list="tmux list-sessions"
alias new="mux copy Default"
alias start="mux start"

# Git Aliases
alias m="git commit -m"
alias a="git add -i"
alias s="git status"
alias add="git add --all"

alias amend="git commit --amend"
alias undo="git reset HEAD@{1}"

alias checkout="git checkout"
alias develop="git checkout develop"
alias master="git checkout master"
alias dev="git checkout develop"

alias stash="git stash"
alias unstash="git stash apply"

alias gdiff="git difftool"
alias conflict="git mergetool"
alias merge="git merge"
alias branch="git branch"
alias branches="git branch -la"

alias push="git push"
alias pull="git pull"

alias submodule="git submodule"
alias sminit="git submodule init; git submodule update"

alias reflog="git reflog"
alias log="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias cf="git diff-tree --no-commit-id --name-only -r"

alias reset="git reset"
alias changes="git diff --cached"

# Git Flow
alias flow="git flow"
alias feature="git flow feature"
alias release="git flow release"
alias hotfix="git flow hotfix"
alias support="git flow support"

# Misc
alias boilerplate="git clone git@github.com:smallhadroncollider/boilerplate.git"
alias chromeXorigin="killall Google\ Chrome 2> /dev/null; open -a Google\ Chrome --args -disable-web-security"
