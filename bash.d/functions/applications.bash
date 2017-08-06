# ----------------------------------------------------------------------------
#  BASH: Functions - Applications
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Application Helper" ${BASH_SOURCE}

#
# Google Chrome
#
function chrome() 
{
	local url="$1"
	if [[ "$url" == "" ]]; then
		echo "Usage: chromeApp <url>"
		return 1
	fi

	local chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
	
	"$chrome" --app="$url"
}

#
# Google Chrome Historie browsen
#
function chrome_history() 
{
	local cols sep
	cols=$(( COLUMNS / 3 ))
	sep='{::}'
	cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
	sqlite3 -separator $sep /tmp/h \
	"select substr(title, 1, $cols), url
	from urls order by last_visit_time desc" |
	awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
	fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

#
# Visual Studio
#
function visu() 
{
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}