#!/usr/bin/env bash
# ----------------------------------------------------------------------------
#  BASH: Functions - Notification
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Notification Helper" ${BASH_SOURCE}

# -----------------------------------------------------------------------------
# ::: BASH SOUND VARS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# -----------------------------------------------------------------------------
case "$OS" in
	darwin)
		readonly SOUND_PATH='/System/Library/Sounds/';
		readonly SOUND_FORMAT='aiff';
		readonly VOICE_RATE=280
		readonly VOICE_TYPE="Bruce"
		;;
	linux)
		readonly SOUND_PATH='/usr/share/sounds/alsa/';
		readonly SOUND_FORMAT='wav';
		;;
	*)
		readonly PS_SYMBOL=$PS_SYMBOL_OTHER
esac

# sound rate for voice messages
readonly SOUND_RATE=2

# -----------------------------------------------------------------------------
# ::: BASH SOUND FUNCTIONS :::::::::::::::::::::::::::::::::::::::::::::::::::
# -----------------------------------------------------------------------------

#
# Play notification sounds on OS X
#
# Available sounds:
#
# 	Basso		Morse		Blow		Ping		Bottle
# 	Frog		Purr		Funk		Sosumi		Glass
# 	Submarine	Pop			Hero		Tink
#
function bash-play()  
{
	if type "afplay" >/dev/null 2>&1 ; 
	then
		if [ -f "$SOUND_PATH$1.$SOUND_FORMAT" ]; 
		then
			afplay -r $SOUND_RATE -v 2 "$SOUND_PATH$1.$SOUND_FORMAT";
		fi
	fi
}

# say...
function bash-say() 
{
	# OS X
	if type "say" >/dev/null 2>&1 ; 
	then
		say -r $VOICE_RATE -v $VOICE_TYPE "$@." 2> /dev/null
	fi

	# Linux/Ubuntu
	if type "espeak" >/dev/null 2>&1 ; 
	then
		espeak "$@." 2> /dev/null
	fi
}

# notification beep(s)...
function bash-beep() 
{
	echo -e "\a"
}

# notification popup/alert/message(s)...
if type "osascript" >/dev/null 2>&1 ; 
then
	function alert() {
		osascript -e "display notification \"$2\" with title \"$1\"";
	}
elif type "notify-send" >/dev/null 2>&1 ; 
then
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi


# ---------------------------------------------------------------------------
#  ::: GROWL :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Standardizing the interface to growlnotify
#
# USAGE: notify "pull --rebase failed" "git"
#
function notify() 
{
	growlnotify -m "$2" "$1" 2> /dev/null
	echo "**********************************************************************"
	echo "**"
	echo "** $2: $1"
	echo "**"
	echo "**********************************************************************"
}

#: GROWL - send notify message to local growl instance
#function growl ()
# { 
#    echo -e $'\e]9;'${1}'\007' ; 
#    return  ; 
#}

# ---------------------------------------------------------------------------
#  ::: PUSHOVER ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Send notifications to smartphone with the free pushover service
#
function pushover() 
{
	PUSHOVERURL="https://api.pushover.net/1/messages.json"
	API_KEY="your-api-here"
	USER_KEY="your-user-key-here"
	DEVICE=""

	TITLE="${1}"
	MESSAGE="${2}"

	$(which curl) \
	-F "token=${API_KEY}" \
	-F "user=${USER_KEY}" \
	-F "device=${DEVICE}" \
	-F "title=${TITLE}" \
	-F "message=${MESSAGE}" \
	"${PUSHOVERURL}" > /dev/null 2>&1
}

