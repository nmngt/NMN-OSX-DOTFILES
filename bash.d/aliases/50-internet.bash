# ----------------------------------------------------------------------------
#  BASH: Aliases - Internet related
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Internet" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
    # Enhanced WHOIS lookups
	alias whois="whois -h whois-servers.net"

	# View HTTP traffic
	alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
	alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

	# URL-encode strings
	alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

fi

