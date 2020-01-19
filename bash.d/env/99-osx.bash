#!/usr/bin/env bash
# ----------------------------------------------------------------------------
#  Environment Settings: OS X
#  $Id$
# 
#  read: 
#  - https://github.com/herrbischoff/awesome-macos-command-line
#  - https://github.com/webpro/awesome-dotfiles
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} OS X" ${BASH_SOURCE}

if [ $IS_MAC ];
then
	if [ "${NBE_SETUP_OSX_ENVIRONMENT}" = 1 ];
	then
		echo "NBE_SETUP_OSX_ENVIRONMENT"
		# Close any open System Preferences panes, to prevent them from overriding
		# settings we’re about to change
		osascript -e 'tell application "System Preferences" to quit'

		# Ask for the administrator password upfront
		sudo -v

		# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
		while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

		# ---------------------------------------------------------------------------
		#  ::: TRACKPAD/KEYBOARD/MOUSE :::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Set a really fast key repeat.
		defaults write NSGlobalDomain KeyRepeat -int 2
		defaults write NSGlobalDomain InitialKeyRepeat -int 15
		defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

		# Turn off keyboard illumination when computer is not used for 5 minutes
		defaults write com.apple.BezelServices kDimTime -int 300

		# Trackpad: enable tap to click for this user and for the login screen
		defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
		defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
		defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

		# Disable press-and-hold for keys in favor of key repeat
		defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

		# Set some locales
		defaults write NSGlobalDomain AppleLanguages -array "de" "en"
		defaults write NSGlobalDomain AppleLocale -string "de_DE@currency=EUR"
		defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
		defaults write NSGlobalDomain AppleMetricUnits -bool false

		# Show language menu in the top right corner of the boot screen
		sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

		# ---------------------------------------------------------------------------
		#  ::: NETWORKING ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Use AirDrop over every interface. srsly this should be a default.
		defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

		# ---------------------------------------------------------------------------
		#  ::: BATTERY :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Show percentage in battery status
		defaults write com.apple.menuextra.battery ShowPercent -string "YES"
		defaults write com.apple.menuextra.battery ShowTime -string "NO"

		# ---------------------------------------------------------------------------
		#  ::: FINDER ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Set the Finder prefs for showing a few different volumes on the Desktop.
		defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
		defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

		# Show all files
		#defaults write com.apple.finder AppleShowAllFiles true

		# Wipe all (default) app icons from the Dock
		#defaults write com.apple.dock persistent-apps -array

		# disable window animations and Get Info animations
		#defaults write com.apple.finder DisableAllAnimations -bool true

		# show all filename extensions
		defaults write NSGlobalDomain AppleShowAllExtensions -bool true

		# show status bar
		defaults write com.apple.finder ShowStatusBar -bool true

		# show path bar
		defaults write com.apple.finder ShowPathbar -bool true

		# Display full POSIX path as Finder window title
		defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

		# Keep folders on top when sorting by name
		defaults write com.apple.finder _FXSortFoldersFirst -bool true

		# When performing a search, search the current folder by default
		defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

		# Disable the warning when changing a file extension
		defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

		# Enable spring loading for directories
		defaults write NSGlobalDomain com.apple.springing.enabled -bool true

		# Remove the spring loading delay for directories
		defaults write NSGlobalDomain com.apple.springing.delay -float 0

		# Avoid creating .DS_Store files on network or USB volumes
		defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
		defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

		# Automatically open a new Finder window when a volume is mounted
		#defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
		#defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
		#defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

		# Use list view in all Finder windows by default
		# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
		defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

		# Remove Dropbox’s green checkmark icons in Finder
		if [ -x "/Applications/Dropbox.app" ];
		then
			file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
			[ -e "${file}" ] && mv -f "${file}" "${file}.bak"
		fi


		# ---------------------------------------------------------------------------
		#  ::: OSX :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Show the ~/Library folder.
		chflags nohidden ~/Library

		# Disable 'Are you sure you want to open this application?' dialog
		#defaults write com.apple.LaunchServices LSQuarantine -bool false

		# Disable disk image verification
		defaults write com.apple.frameworks.diskimages skip-verify -bool true
		defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
		defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

		# Expand save panel by default
		defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

		# Expand print panel by default
		defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

		# Automatically quit printer app once the print jobs complete
		defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

		# Set highlight color to green
		defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

		# Increase window resize speed for Cocoa applications
		defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

		# Disable opening and closing window animations
		defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false



		# Disable smart dashes as they’re annoying when typing code
		defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

		# Disable smart quotes as they’re annoying when typing code
		defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

		# Disable auto-correct
		defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

		# Disable automatic capitalization as it’s annoying when typing code
		defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false



		# Chime When Charging
		defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
		open /System/Library/CoreServices/PowerChime.app

		# Dark Theme to menubar
		#sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

		# Appearance: Graphite
		#defaults write -g AppleAquaColorVariant -int 6

		# ---------------------------------------------------------------------------
		#  ::: SAFARI ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Privacy: don’t send search queries to Apple
		defaults write com.apple.Safari UniversalSearchEnabled -bool false
		defaults write com.apple.Safari SuppressSearchSuggestions -bool true

		# Hide Safari's bookmark bar.
		#defaults write com.apple.Safari ShowFavoritesBar -bool false

		# Remove useless icons from Safari’s bookmarks bar
		# defaults write com.apple.Safari ProxiesInBookmarksBar "()"

		# Press Tab to highlight each item on a web page
		defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

		# Set Safari’s home page to `about:blank` for faster loading
		# defaults write com.apple.Safari HomePage -string "about:blank"

		# Prevent Safari from opening ‘safe’ files automatically after downloading
		defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

		# Allow hitting the Backspace key to go to the previous page in history
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

		# Disable Safari’s thumbnail cache for History and Top Sites
		defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

		# Enable Safari’s debug menu
		defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

		# Enable the Develop menu and the Web Inspector in Safari
		defaults write com.apple.Safari IncludeDevelopMenu -bool true
		defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

		# Add a context menu item for showing the Web Inspector in web views
		defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
		# ---------------------------------------------------------------------------
		#  ::: SCREEN ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Require password immediately after sleep or screen saver begins
		#defaults write com.apple.screensaver askForPassword -int 1
		#defaults write com.apple.screensaver askForPasswordDelay -int 0

		# Disable shadow in screenshots
		defaults write com.apple.screencapture disable-shadow -bool true

		# Enable subpixel font rendering on non-Apple LCDs
		# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
		defaults write NSGlobalDomain AppleFontSmoothing -int 1

		# Enable HiDPI display modes (requires restart)
		#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

		# Save screenshots to the ~/Desktop/_Screenshots
		mkdir ~/Documents/_Screenshots
		defaults write com.apple.screencapture location -string "$HOME/Documents/_Screenshots"

		# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
		defaults write com.apple.screencapture type -string "png"

		# ---------------------------------------------------------------------------
		#  ::: DOCK ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# dock position
		#defaults write com.apple.dock orientation left

		# Set Dark Theme to Dock & Fullscreen
		#defaults write NSGlobalDomain AppleInterfaceStyle Dark;

		# Remove the auto-hiding Dock delay
		#defaults write com.apple.Dock autohide-delay -float 0

		# Automatically hide and show the Dock
		defaults write com.apple.dock autohide -bool true

		# Set the icon size of Dock items to 36 pixels
		#defaults write com.apple.dock tilesize -int 38

		# Don’t animate opening applications from the Dock
		#defaults write com.apple.dock launchanim -bool false

		# Show indicator lights for open applications in the Dock
		defaults write com.apple.dock show-process-indicators -bool true

		# Removed genie animation
		#defaults write com.apple.dock mineffect suck; killall Dock

		# Removes bouncing animation
		#defaults write com.apple.dock no-bouncing -bool true


		# ---------------------------------------------------------------------------
		#  ::: SPOTLIGHT ..:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Hide Spotlight tray-icon (and subsequent helper)
		#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

		# Disable Spotlight indexing for any volume that gets mounted and has not yet
		# been indexed before.
		# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
		sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

		# Change indexing order and disable some search results
		# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
		# 	MENU_DEFINITION
		# 	MENU_CONVERSION
		# 	MENU_EXPRESSION
		# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
		# 	MENU_WEBSEARCH             (send search queries to Apple)
		# 	MENU_OTHER
		defaults write com.apple.spotlight orderedItems -array \
			'{"enabled" = 1;"name" = "APPLICATIONS";}' \
			'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
			'{"enabled" = 1;"name" = "DIRECTORIES";}' \
			'{"enabled" = 1;"name" = "PDF";}' \
			'{"enabled" = 0;"name" = "FONTS";}' \
			'{"enabled" = 1;"name" = "DOCUMENTS";}' \
			'{"enabled" = 0;"name" = "MESSAGES";}' \
			'{"enabled" = 1;"name" = "CONTACT";}' \
			'{"enabled" = 0;"name" = "EVENT_TODO";}' \
			'{"enabled" = 0;"name" = "IMAGES";}' \
			'{"enabled" = 1;"name" = "BOOKMARKS";}' \
			'{"enabled" = 0;"name" = "MUSIC";}' \
			'{"enabled" = 0;"name" = "MOVIES";}' \
			'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
			'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
			'{"enabled" = 0;"name" = "SOURCE";}' \
			'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
			'{"enabled" = 0;"name" = "MENU_OTHER";}' \
			'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
			'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
			'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
			'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

		# Load new settings before rebuilding the index
		killall mds > /dev/null 2>&1

		# Make sure indexing is enabled for the main volume
		sudo mdutil -i on / > /dev/null

		# Rebuild the index from scratch
		sudo mdutil -E / > /dev/null


		# ---------------------------------------------------------------------------
		#  ::: ACTIVITY MONITOR ::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Show the main window when launching Activity Monitor
		defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

		# Visualize CPU usage in the Activity Monitor Dock icon
		defaults write com.apple.ActivityMonitor IconType -int 5

		# Show all processes in Activity Monitor
		defaults write com.apple.ActivityMonitor ShowCategory -int 0

		# Sort Activity Monitor results by CPU usage
		defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
		defaults write com.apple.ActivityMonitor SortDirection -int 0

		# ---------------------------------------------------------------------------
		#  ::: APP STORE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Enable the WebKit Developer Tools in the Mac App Store
		defaults write com.apple.appstore WebKitDeveloperExtras -bool true

		# Enable Debug Menu in the Mac App Store
		defaults write com.apple.appstore ShowDebugMenu -bool true

		# Enable the automatic update check
		defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

		# Check for software updates daily, not just once per week
		defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

		# do NOT Download newly available updates in background
		defaults write com.apple.SoftwareUpdate AutomaticDownload -int 0

		# Install System data files & security updates
		defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

		# Automatically download apps purchased on other Macs
		defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

		# Turn on app auto-update
		defaults write com.apple.commerce AutoUpdate -bool true

		# DISallow the App Store to reboot machine on macOS updates
		defaults write com.apple.commerce AutoUpdateRestartRequired -bool false

		# ---------------------------------------------------------------------------
		#  ::: TIME MACHINE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Prevent Time Machine from prompting to use new hard drives as backup volume
		# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

		# Disable local Time Machine backups
		hash tmutil &> /dev/null && sudo tmutil disablelocal

		# ---------------------------------------------------------------------------
		#  ::: PHOTOS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Prevent Photos from opening automatically when devices are plugged in
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

		# ---------------------------------------------------------------------------
		#  ::: GOOGLE CHROME :::::::::::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------

		# Disable the all too sensitive backswipe on trackpads
		defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
		defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

		# ---------------------------------------------------------------------------
		#  ::: RESTART AFFECTED APPS :::::::::::::::::::::::::::::::::::::::::::::::
		# ---------------------------------------------------------------------------
		for app in "Activity Monitor" \
			"Address Book" \
			"Calendar" \
			"cfprefsd" \
			"Contacts" \
			"Dock" \
			"Finder" \
			"Google Chrome Canary" \
			"Google Chrome" \
			"Mail" \
			"Messages" \
			"Opera" \
			"Photos" \
			"Safari" \
			"SizeUp" \
			"Spectacle" \
			"SystemUIServer" \
			"Terminal" \
			"Transmission" \
			"Tweetbot" \
			"Twitter" \
			"iCal"; do
			killall "${app}" &> /dev/null
		done

	fi 
fi

