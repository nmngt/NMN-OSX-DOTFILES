# ----------------------------------------------------------------------------
#  BASH: Functions - String
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} String Helper" ${BASH_SOURCE}

# Convert to lowercase.
function lower() 
{
	tr '[:upper:]' '[:lower:]'
}

# Convert to uppercase.
function upper() 
{
	tr '[:lower:]' '[:upper:]'
}

function indent() 
{
	local prefix=$1
	sed "s/^/$1  /"
}

# Helper to clean vars
function trimspace() 
{
	echo "${@//[[:blank:]]/}"
}

# Helper to clean strings
function trim()
{
	buffer=$1
	buffer=${buffer##[[:space:]]}
	buffer=${buffer%%[[:space:]]}
	echo $buffer
}