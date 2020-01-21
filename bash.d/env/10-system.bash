# ----------------------------------------------------------------------------
#  Environment Variables: System, Host & OS 
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[skull]} System" ${BASH_SOURCE}

#
# os
#
export OS=${ENV:=darwin}

if [ $IS_MAC ]; 
then
	export OS_NAME=$(sw_vers -productName)
	export OS_VERSION=$(sw_vers -productVersion)
fi

#
# system
#
export KERNEL="$(uname -smr)"
export MACHINE=$(uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
export PLATFORM="$MACHINE-$OS-$OSVERSION"

#
# proc/cpu
#
if [ $IS_MAC ]; 
then
	export LOAD=$(w | grep up | awk '{print $10" "$11" "$12}')	# current cpu load
	export PROC_CORES=$(/usr/sbin/sysctl -n hw.ncpu) 			# Available threads
fi

#
# filesystem
#
export FIGNORE="CVS:.svn:.git:.DS*" # ignore while tab-completion

#
# network
#
# export LAN="en0"
# export WIFI="en1"
# export INTERFACE="en0"

#
# hostname
#
export FQDN=$(hostname -f)
export HOSTNAME=$(hostname -s)

#
# uptime
#
# export UPTIME_DAYS=$(uptime | awk {'print $3'})
# export UPTIME_HOURS=$(uptime | awk {'print $5'})
# export UPTIME="${UPTIME_DAYS} Tage ${UPTIME_HOURS} Stunden"

#
# battery
#
# if [ $IS_MAC ]; 
# then
# 	#export BATTERY_INFO=$(ioreg -rc AppleSmartBattery)
# 	#export BATTERY_CURRENT_CHARGE=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
# 	#export BATTERY_TOTAL_CHARGE=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
# 	#export BATTERY_PERCENT = $(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';')
# 	#export BATTERY_TIME = $(pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f3 -d';')
# fi

# 
# Trim new lines and copy to clipboard
#
if [ $IS_MAC ]; 
then
	alias ct="tr -d '\n' | pbcopy"
fi

# 
# Zwischenablage
#
# if [ "$OS" = darwin ]; 
if [ $IS_MAC ]; 
then
	alias clip='pbcopy'
# elif [ "$OS" = linux ];
elif [ $IS_LINUX ];
then
	alias clip='xsel --clipboard'
	alias open='xdg-open'
# elif [ "$OS" = cygwin ]; 
elif [ $IS_CYGWIN ]; 
then
	alias clip='getclip'
	alias open='cygstart'
fi

