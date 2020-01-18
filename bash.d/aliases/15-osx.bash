# ----------------------------------------------------------------------------
#  BASH: Aliases - OSX
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} OS X" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
    # Show/hide hidden files in Finder
	alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	# show/hide desktop icons
	alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
	alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

    # Mute/Unmute the system volume. Plays nice with all other volume settings.
    alias mute="osascript -e 'set volume output muted true'"
    alias unmute="osascript -e 'set volume output muted false'"

    # Get OS X Software Updates, and update installed Ruby gems, Homebrew, and their installed packages
    #alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; sudo gem update --system; sudo gem update'

    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
fi
