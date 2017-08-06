# ----------------------------------------------------------------------------
#  BASH: Aliases - Source Control Management
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Source Control Management" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: GIT & GITHUB ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
if [ -x "/usr/bin/git" ]; 
then
    nbe_msg "${icon[child]} - Git" ${BASH_SOURCE}

    #
    # git Aliases
    #
    alias g='git'
    alias gc='git clone'

    # 
    # Autocomplete for 'g' as well
    #
    #complete -o default -o nospace -F _git g
fi