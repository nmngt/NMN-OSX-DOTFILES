# ----------------------------------------------------------------------------
#  BASH: Functions - Conditional
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Conditionals" ${BASH_SOURCE}

function type_exists() 
{
	if [ $(type -P $1) ]; 
	then
		return 0
	fi
	return 1
}

function is_os() 
{
	if [[ "${OSTYPE}" == $1* ]]; 
	then
		return 0
	fi
	return 1
}

# Helper to test if executable exists
function exists() 
{ 
	type -t "$1" > /dev/null 2>&1; 
}

# check if $1 is a file, dir, symlink or executable
function type_of_file()
{	
	# $1 - filename
	if [ ! -n "$1" ]; then
		usage ${FUNCNAME} "filename" $E_BADARGS
	fi
	
	[ -f "$1" ] && { return "file"; exit 0; }
	[ -d "$1" ] && { return "dir"; exit 0; }
	[ -L "$1" ] && { return "symlink"; exit 0; }
	[ -x "$1" ] && { return "executable"; exit 0; }
}

# check if $1 is a file
function is_file()
{	
	# $1 - filename
	[ -f "$1" ] && return $TRUE || return $FALSE
}

function is_exists() 
{
  if [[ -e "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_not_exists() 
{
  if [[ ! -e "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_file() 
{
  if [[ -f "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_not_file() 
{
  if [[ ! -f "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_dir() 
{
  if [[ -d "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_not_dir() 
{
  if [[ ! -d "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_symlink() 
{
  if [[ -L "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_not_symlink() 
{
  if [[ ! -L "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_empty() 
{
  if [[ -z "$1" ]]; 
  then
    return 0
  fi
  return 1
}

function is_not_empty() 
{
  if [[ -n "$1" ]]; 
  then
    return 0
  fi
  return 1
}



