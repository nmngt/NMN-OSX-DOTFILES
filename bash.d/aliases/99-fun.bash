# ----------------------------------------------------------------------------
#  BASH: Aliases - Fun
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Fun Stuff" ${BASH_SOURCE}

if [ "$OS" = darwin ]; 
then
	# Look busy
	alias busy='cat /dev/urandom | hexdump -C | grep "ca fe"'

	# Star Wars
	alias starwars='telnet towel.blinkenlights.nl'

	# tron
	alias tron='ssh sshtron.zachlatta.com'

	# rickroll
	alias roll='curl -s -L http://bit.ly/10hA8iC | bash'
fi