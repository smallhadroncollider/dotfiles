taps=(
    homebrew/versions
    homebrew/dupes
    homebrew/homebrew-php
)

brew=(
    cmake
    composer
    diff-so-fancy
    exiftool
    flow
    fontforge
    git
    git-flow
    graphviz
    grc
    icdiff
    keybase
    libsass
    node
    "php70 --without-apache"
    php70-mcrypt
    phpmd
    php-code-sniffer
    pkg-config
    proselint
    randomize-lines
    ruby
    shellcheck
    terminal-notifier
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
    divvy
    docker
    expandrive
    fantastical
    fluid
    gpgtools
    google-chrome
    google-chrome-canary
    haskell-platform
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

npm=(
    babel-eslint
    babel-cli
    browser-sync
    csslint
    eslint
    eslint-plugin-react
    git-recent
    grunt-cli
    jsonlint
    loadtest
    markdown-to-slides
    pulp
    karma-cli
    trash-cli
    webpack
)

gem=(
    bundler
    css_lint
    capistrano
    mdl
)

pip=(
    grip
    vim-vint
    yamllint
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
npm install -g ${npm[@]}

sudo easy_install pip
sudo pip install ${pip[@]}

vagrant plugin install ${vagrant[@]}

printf "\n\nCopy across ~/VirtualBox VMs/ and run register-vms\n"
