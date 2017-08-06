# ----------------------------------------------------------------------------
#  BASH: Aliases - Network
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Network" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
	# ping 10 times
	alias ping='ping -c 10'

	# show all open ports
	#alias openports='netstat -nap --tcp4' <- LINUX
	alias openports='sudo lsof -iTCP -sTCP:LISTEN -P'
	
	# Show all open TCP/IP sockets
	alias opensockets='lsof -i'

	# Display open sockets
	alias lsock='sudo /usr/sbin/lsof -i -P'
	
	# Display only open UDP sockets
	alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'
	
	# Display only open TCP sockets
	alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'
	
	# Get info on connections for en0
	alias ipInfo0='ipconfig getpacket en0'

	# Get info on connections for en1
	alias ipInfo1='ipconfig getpacket en1'

	# All ipfw rules inc/ blocked IPs
	alias showBlocked='sudo ipfw list'
fi