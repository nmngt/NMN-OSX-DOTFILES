# ----------------------------------------------------------------------------
#  BASH: Functions - DNS
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} DNS Helper" ${BASH_SOURCE}

# 
# Check if Domain is registered (http://gist.github.com/217660)
# 
function dns() 
{
	dig soa "$1" | grep -q "^$1" && echo "Registered" || echo "Available"
}


# 
# official way to flush dns on OS X 10.7+
#
function dns_flush() 
{
	sudo discoveryutil mdnsflushcache || sudo killall -HUP mDNSResponder
}

