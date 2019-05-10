brew=(
    cmake
    composer
    ctags-exuberant
    diff-so-fancy
    exiftool
    flow
    fontforge
    git
    git-flow
    graphviz
    grc
    haskell-stack
    hub
    icdiff
    libsass
    php
    php-code-sniffer
    pkg-config
    proselint
    purescript
    randomize-lines
    ranger
    ruby
    shellcheck
    taskell
    terminal-notifier
    tidy-html5
    tree
    the_silver_searcher
    wget
    yarn
)

cask=(
    adobe-connect
    authy
    backblaze
    caffeine
    dash
    daisydisk
    divvy
    docker
    expandrive
    fantastical
    fluid
    flux
    gpg-suite
    google-chrome
    google-chrome-canary
    istat-menus
    java
    keybase
    kitematic
    little-snitch
    mactex
    ngrok
    numi
    paw
    qlmarkdown
    quicklook-json
    sequel-pro
    skype
    slack
    sublime-text-dev
    superduper
    transmit
    tunnelbear
    vagrant
    virtualbox
    vmware-fusion
)

yarn=(
    babel-cli
    browser-sync
    create-react-app
    csslint
    eslint
    eslint-plugin-immutable
    git-recent
    grunt-cli
    gulp-cli
    jsonlint
    loadtest
    markdown-to-slides
    pulp
    karma-cli
    trash-cli
    webpack
    webpack-dev-server
)

gem=(
    tmuxinator
    bundler
    scss_lint
    capistrano
    mdl
)

composer=(
    "laravel/installer"
    "vimeo/psalm" # linter - PHP
    "phan/phan"
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
    vagrant-berkshelf
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

brew cleanup

for i in "${yarn[@]}"
do
    yarn global add $i
done

gem install ${gem[@]}
composer global require ${composer[@]}

sudo easy_install pip
sudo pip install ${pip[@]}

for i in "${stack[@]}"
do
    stack install $i
done

vagrant plugin install ${vagrant[@]}

printf "\n\nCopy across ~/VirtualBox VMs/ and run register-vms\n"
