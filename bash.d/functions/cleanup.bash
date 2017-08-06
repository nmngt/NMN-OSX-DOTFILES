# ----------------------------------------------------------------------------
#  BASH: Functions - Cleanup
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Housekeeping" ${BASH_SOURCE}

# clear screen
alias c='clear'

# empty local Trash
alias trash="rm -rf ~/.Trash"


# Clean up MAC .DS_Store files
alias cleanup_ds='find ./ -type f | grep .DS_Store | xargs rm'

# Clean up temp files
alias cleanup_tmp='rm -f *.tmp *.temp'

# Clean up Subversion files
alias cleanup_svn='find . -name '.svn' | xargs rm -Rf'

# Clean up LaunchServices to remove duplicates in the "Open With" menu
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# ---------------------------------------------------------------------------
#  ::: CLEAR LOG FILES :::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# if [ IS_MAC ]; 
# then
# 	[[ "${NMN_DEBUG}" = 1 ]] && echo -e " - Clear system log files (${DEBUG_YELLOW}#33${DEBUG_TRANSE})"

# 	#sudo rm -rf /var/log/*
# 	#sudo rm -rf /private/var/vm
# 	sudo rm -rf ~/Library/logs/*	
# 	sudo rm -rf ~/Library/Caches/*
# 	sudo rm -rf /private/var/folders/*
# 	sudo rm -rf /.DocumentRevisions-V100/
# 	sudo rm -rf ~/Library/Autosave\ Information/*
# 	sudo rm -rfv /Library/Logs/Adobe/* &>/dev/null
# 	sudo rm -rfv /private/var/log/asl/*.asl &>/dev/null
# 	sudo rm -rfv ~/Library/Logs/CoreSimulator/* &>/dev/null
# 	sudo rm -rfv /Library/Logs/DiagnosticReports/* &>/dev/null
# 	sudo rm -rfv ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
	
# 	[[ "${NMN_DEBUG}" = 1 ]] && echo -e " - Clear Adobe cache files (${DEBUG_YELLOW}#33${DEBUG_TRANSE})"
# 	sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

# 	[[ "${NMN_DEBUG}" = 1 ]] && echo -e " - Clear system cache files (${DEBUG_YELLOW}#33${DEBUG_TRANSE})"
# 	sudo rm -rfv /System/Library/Caches/*

# 	[[ "${NMN_DEBUG}" = 1 ]] && echo -e " - Purge memory (${DEBUG_YELLOW}#33${DEBUG_TRANSE})"
# 	purge

# 	[[ "${NMN_DEBUG}" = 1 ]] && echo -e " - Clear lib cache files (${DEBUG_YELLOW}#33${DEBUG_TRANSE})"
# 	for x in $(ls ~/Library/Containers/)
# 	do
# 	    echo "cleaning ~/Library/Containers/$x/Data/Library/Caches"
# 	    rm -rf ~/Library/Containers/$x/Data/Library/Caches/*
# 	    echo "done cleaning ~/Library/Containers/$x/Data/Library/Caches"
# 	done
# fi