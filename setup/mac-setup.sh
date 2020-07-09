brew=(
    cmake
    cmt
    composer
    ctags-exuberant
    diff-so-fancy
    exiftool
    git
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
    dash
    daisydisk
    docker
    fantastical
    gpg-suite
    google-chrome
    istat-menus
    keybase
    little-snitch
    mactex-no-gui
    paw
    qlmarkdown
    quicklook-json
    slack
    superduper
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

stack=(
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
composer global require ${composer[@]}

pip3 install --user ${pip[@]}

for i in "${stack[@]}"
do
    stack install $i
done

vagrant plugin install ${vagrant[@]}
