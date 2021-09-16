taps=(
    homebrew/cask-versions
    homebrew/cask-fonts
    buo/cask-upgrade
)

brew=(
    antigen
    direnv
    exa
    fzf
    mackup
    node
    reattach-to-user-namespace
    ripgrep
    tmux
    "vim --with-override-system-vi"
    zsh
    zsh-syntax-highlighting
)

cask=(
    1password
    alfred
    iterm2
)

fonts=(
    font-fira-code-nerd-font
    font-fira-mono-nerd-font
    font-lato
)


# Create iCloud alias
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/iCloud

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install binaries
for tap in "${taps[@]}"
do
    brew tap $tap
done

for i in "${brew[@]}"
do
    brew install $i
done

for i in "${cask[@]}"
do
    brew cask install $i
done

for i in "${fonts[@]}"
do
    brew cask install $i
done

brew cleanup

# Setup Mackup
ln -s ~/iCloud/.mackup-sync/.mackup ~/
ln -s ~/iCloud/.mackup-sync/.mackup.cfg ~/
mackup restore

# Setup ZSH
sudo sh -c 'printf "\n/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh

# SSH Permissions
chmod -R 700 ~/.ssh
chmod -R 600 ~/.ssh/keys

# add Ruby to path
sudo perl -pi -e '$_ .= qq(/usr/local/opt/ruby/bin\n) if /\/usr\/local\/bin/' /etc/paths

# Setup Tmux plugin manager - tmux needs to be running at this point
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# create vim directories and install plugins
mkdir -p "$HOME/.vim/tmp"
mkdir -p "$HOME/.vim/undo"
vim +PlugInstall +qall +silent

# open iTerm
open -a iTerm
