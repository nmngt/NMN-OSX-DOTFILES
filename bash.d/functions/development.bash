# ----------------------------------------------------------------------------
#  BASH: Functions - Devel
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Development Helper" ${BASH_SOURCE}

# Edit /private/etc/hosts file
alias edit_hosts='sudo edit /private/etc/hosts'

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

# Grabs headers from web page
function http-headers() 
{ 
	/usr/bin/curl -I -L $@ ; 
}

# Download a web page and show info on what took time
function http-debug () 
{ 
	/usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; 
}

# find todo notes in current project
function find-todos()
{
  #local m=$(trimspace $(git diff --numstat 2> /dev/null | wc -l))
  LOCAL_DIR=$(git rev-parse --show-toplevel 2> /dev/null)
  LOCAL_DIR=${LOCAL_DIR:-.}
  find "${LOCAL_DIR}" -type f -exec grep -H -n '(TODO|FIX(ME)?):' {} \; 2> /dev/null
}