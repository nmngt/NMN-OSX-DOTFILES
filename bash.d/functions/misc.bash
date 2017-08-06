# ----------------------------------------------------------------------------
#  BASH: Functions - Misc
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Misc Helper" ${BASH_SOURCE}

# remind me, its important!
# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme()
{
    sleep $1 && zenity --info --text "$2" &
}

# regex match and replace from: https://gist.github.com/opsb/4409156
function regex() 
{
  gawk "match(\$0, /${1}/, ary) { print ary[${2:-0}] }";
}

#: DIFF - compare directories via diff
function fs_CompareDirectories()
{
    #: original shell command
    # diff -qr dirA dirB | grep -v -e 'DS_Store' -e 'Thumbs' | sort > diffs.txt
    
    # final shell function
    diff -qr $1 $2 | grep -v -e 'DS_STORE' -e 'Thumbs' | sort
}

# binary diff
function binarydiff() 
{
  vimdiff <(xxd "${1}") <(xxd "${2}")
}

# print futurama quote
function futurama()
{
	curl -Is slashdot.org | sed -ne '/^X-[FBL]/s/^X-//p'
}

#:  rm() - a wrapper for rm to move files to .TRASH folder instead
#:  of removing them... 
function rmToTrash()
{
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}

#: TERMINAL - Modify terminal xtitle
function xtitle()
{
    case "$TERM" in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)
        ;;
    esac
}

# MAN - Enhance man output
function eman()
{
    for i ; do
    xtitle The $(basename $1|tr -d .[:digit:]) manual
    command man -a "$i"
    done
}