brew=(
    bat
    cmake
    cmt
    composer
    ctags-exuberant
    diff-so-fancy
    exiftool
    git
    git-delta
    git-flow
    grc
    haskell-stack
    hub
    icdiff
    php
    php-code-sniffer
    pkg-config
    ruby
    shellcheck
    taskell
    terminal-notifier
    tree
    the_silver_searcher
    wget
)

cask=(
    authy
    backblaze
    carbon-copy-cloner
    dash
    daisydisk
    docker
    fantastical
    gpg-suite
    istat-menus
    little-snitch
    paw
    qlmarkdown
    quicklook-json
    slack
    vagrant
    virtualbox
    vmware-fusion
    visual-studio-code
    webcatalog
)

npm=(
    git-recent
    jsonlint
    stylelint
    stylelint-config-standard
    trash-cli
)

gem=(
    tmuxinator
    bundler
    mdl
)

composer=(
    "laravel/installer"
)

pip=(
    grip # markdown to github-style HTML
    pygments
    pygments-lexer-babylon
    vim-vint
    yamllint
)

cabal=(
    ghcid
    hfmt
    hindent
    hlint
    stylish-haskell
)

vagrant=(
    vagrant-vbguest
    vagrant-hostsupdater
    vagrant-share
)

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

for i in "${npm[@]}"
do
    npm install --global $i
done

gem install ${gem[@]}

# tmuxinator auto-complete
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator

composer global require ${composer[@]}

pip3 install --user ${pip[@]}

cabal update

for i in "${cabal[@]}"
do
    cabal install $i
done

vagrant plugin install ${vagrant[@]}
