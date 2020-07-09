# Keep sudo going for length of script
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name
read -p "Nice computer name: " niceName
sudo scutil --set ComputerName "$niceName"

read -p "Computer name: " computerName
sudo scutil --set HostName "$computerName"
sudo scutil --set LocalHostName "$computerName"

# Allow key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Expanding the save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Save to disk rather than iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes/dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable system-wide resume
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Full keyboard access
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable sudden motion sensor
sudo pmset -a sms 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Require passwords immediately after sleep/screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Better font rendering on non-Apple displays
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Finder
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle Clmv
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true

killall Finder

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 2000
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock

# Safari
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Mail
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Chrome
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE
defaults write com.google.Chrome.canary.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE
