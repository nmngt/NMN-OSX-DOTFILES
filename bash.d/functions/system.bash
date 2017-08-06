# ----------------------------------------------------------------------------
#  BASH: Functions - System
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} System Helper" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: Processes :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# shortcut for kill -9
function killhard ()
{
    kill -9 "$1"
}

# fkill - kill process
function fkill() 
{
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ];
	then
		kill -${1:-9} $pid
	fi
}

#: find out the pid of a specified process
#
# Note that the command name can be specified via a regex
# E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
# Without the 'sudo' it will only find processes of the current user
function find_pid() 
{ 
	lsof -t -c "$@" ; 
}

#: List processes owned by my user
function find_my_processes() 
{ 
	ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; 
}

#: SHELL - TopTen Shell-commands
function topten()
{
    history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail | sort -nr
}

# ---------------------------------------------------------------------------
#  ::: HARDWARE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# get battery level on osx
function detect_battery() 
{
	ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%\n", $10/$5 * 100)}'
}

# Disk Usage Detection - Begin
function detect_disk() 
{
	diskusage="unknown"
	if type -p df >/dev/null 2>&1; 
	then
		if [[ "${distro}" == "Mac OS X" ]]; 
		then
			totaldisk=$(df -H / 2>/dev/null | tail -1)
		else
			totaldisk=$(df -h --total 2>/dev/null | tail -1)
		fi
		
		disktotal=$(awk '{print $2}' <<< "${totaldisk}")
		diskused=$(awk '{print $3}' <<< "${totaldisk}")
		diskusedper=$(awk '{print $5}' <<< "${totaldisk}")
		diskusage="${diskused} / ${disktotal} (${diskusedper})"
		diskusage_verbose=$(sed 's/%/%%/' <<< $diskusage)
	fi
	msg "Detecting current disk usage...found as '$diskusage_verbose'"
}



# detect uptime
function detect_uptime() 
{
	unset uptime
	boot=$(sysctl -n kern.boottime | cut -d "=" -f 2 | cut -d "," -f 1)
	now=$(date +%s)
	uptime=$(($now-$boot))

	if [[ -n ${uptime} ]]; 
	then
		secs=$((${uptime}%60))
		mins=$((${uptime}/60%60))
		hours=$((${uptime}/3600%24))
		days=$((${uptime}/86400))

		uptime="${mins}m"
		
		if [ "${hours}" -ne "0" ]; 
		then
			uptime="${hours}h ${uptime}"
		fi
		if [ "${days}" -ne "0" ]; 
		then
			uptime="${days}d ${uptime}"
		fi
	fi
	msg "Detecting current uptime...found as '$uptime'"
}
