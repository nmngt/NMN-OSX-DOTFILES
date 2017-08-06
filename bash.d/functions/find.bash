# ----------------------------------------------------------------------------
#  BASH: Functions - find
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Find(er) Helper" ${BASH_SOURCE}

# 
# use spotlight for locate command
# http://hints.macworld.com/article.php?story=20050507212241122
#
function spotlight()
{
	mdfind "kMDItemDisplayName == '$@'wc"; 
}

# shortcut for find
function f()
{
	find . -name "*$1*"
}

# get open ports from user
function find_portuser()
{
    lsof -i :"$1"
}

# find string in file in directory
function find_string()
{
  if [ $# != 2 ]; then
    echo "Usage:  findstring <dir> <string>"
  else
    find $1 -exec grep "$2" {} \; -print
  fi
}

# find file in directory
function find_file()
{
  if [ $# != 2 ]; then
    echo "Usage:  findfile <dir> <filename>"
  else
    find $1 -name "$2" -print
  fi
}

#
# Finds files with names containing the parameter
# Usage: $FUNCNAME <target-filename>
#
function ff()
{
  local target=$1
  if [[ "$target" == "" ]]; then
    echo "Finds files with names containing the parameter"
    echo "Usage: $FUNCNAME <target-filename>"
    return 1;
  else
    if [[ $(command -v ag) ]]; then
      ag -g ".*${target}.*"
    elif [[ $(command -v ack) ]]; then
      ack -g ".*${target}.*"
    else
      find . -name "*${target}.*"
    fi
  fi
}