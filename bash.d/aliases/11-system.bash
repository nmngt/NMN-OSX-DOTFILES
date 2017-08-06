# ----------------------------------------------------------------------------
#  BASH: Aliases - System Aliases
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} System" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
	#: Find memory hogs
	alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
	alias memory_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
	alias memory_hogs_top='top -l 1 -o rsize | head -20'
fi

