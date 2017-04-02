taps=(
    caskroom/versions
    caskroom/fonts
)

brew=(
    antigen
    direnv
    mackup
    reattach-to-user-namespace
    tmux
    "vim --with-override-system-vi"
    z
    zsh
    zsh-syntax-highlighting
)

cask=(
    1password
    alfred
    iterm2-nightly
)

fonts=(
    font-inconsolata
    font-fira-code
)

gem=(
    tmuxinator
)

npm=(
    tern
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

brew cleanup --force
brew cask cleanup
brew pin python

gem install ${gem[@]}
npm install -g ${npm[@]}

# Setup Mackup
ln -s ~/iCloud/.mackup/.mackup ~/
ln -s ~/iCloud/.mackup/.mackup.cfg ~/
mackup restore

# Setup ZSH
sudo sh -c 'printf "\n/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh

# SSH Permissions
chmod -R 700 ~/.ssh
chmod -R 600 ~/.ssh/keys

# Setup Tmux plugin manager - tmux needs to be running at this point
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Final message
printf "\n\nNow run visudo and add the 'Defaults tty_tickets' option\n"
