taps=(
    homebrew/versions
    homebrew/dupes
    homebrew/homebrew-php
    GoogleChrome/simplehttp2server
)

brew=(
    cabal-install
    cmake
    composer
    ctags-exuberant
    diff-so-fancy
    exiftool
    flow
    fontforge
    git
    git-flow
    ghc
    graphviz
    grc
    haskell-stack
    hub
    icdiff
    keybase
    libsass
    node
    php72
    php71-ast
    phpctags
    phpmd
    php-code-sniffer
    pkg-config
    proselint
    purescript
    randomize-lines
    ranger
    ruby
    shellcheck
    simplehttp2server
    terminal-notifier
    tidy-html5
    tree
    the_silver_searcher
    wget
    yarn
)

cask=(
    backblaze
    caffeine
    chefdk
    dash
    daisydisk
    divvy
    docker
    expandrive
    fantastical
    fluid
    gpgtools
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
    spotify
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
    bower
    create-react-app
    create-react-app-native
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
    tern
    webpack
    webpack-dev-server
)

gem=(
    bundler
    scss_lint
    capistrano
    mdl
)

composer=(
    "laravel/installer"
    "phan/phan"
)

pip=(
    grip
    vim-vint
    yamllint
)

cabal=(
    happy
    hlint
    hfmt
    hdevtools
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

brew cleanup --force
brew cask cleanup

gem install ${gem[@]}
composer global require ${composer[@]}
yarn global add ${npm[@]}

sudo easy_install pip
sudo pip install ${pip[@]}

for i in "${cabal[@]}"
do
    cabal install $i
done

vagrant plugin install ${vagrant[@]}

printf "\n\nCopy across ~/VirtualBox VMs/ and run register-vms\n"
