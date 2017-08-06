# ----------------------------------------------------------------------------
#  BASH: Functions - Network
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Network Helper" ${BASH_SOURCE}

# get external IP-adress
function myip() 
{
	curl --silent --fail 'ifconfig.co'
}

#: NetInfo - Get some network statistics
function netinfo()
{
	IFC
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    echo ""
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    echo ""
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    # /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
}

#: ...
function netlink() 
{
	sleep 30
	ping -c 1 dino | grep -q '100% packet loss' && netlink
}