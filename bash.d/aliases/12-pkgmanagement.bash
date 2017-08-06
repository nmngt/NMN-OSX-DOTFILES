# ----------------------------------------------------------------------------
#  BASH: Aliases - Package Management
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Package Management" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
    #
    # Use MacPorts package manager
    #
    # Syntax: 
    #   sudo port <action> [portname|pseudo-portname|port-url] [@version] [+-variant]
    #
    # Available actions (see manpage or action help for a full actions listing):
    # ------------------------------------------------------------------------------
    #   activate, archive, build, checksum, clean, configure, contents, deactivate, 
    #   dependents, deps, distcheck, dmg, dpkg, extract, fetch, help, info, install, 
    #   installed, lint, list, livecheck, load, mirror, notes, outdated, provides, 
    #   quit, rpm, search, select, selfupdate, test, unarchive, uninstall, unload, 
    #   upgrade, usage, variants, version, work
    #
    if [ -x /opt/local/bin/port ]; 
    then
        alias apti='sudo port install'
        alias aptii='sudo port install -y'
        alias aptu='sudo port -v selfupdate'
        alias aptuu='sudo port -v upgrade'
        alias aptua='sudo port -v upgrade all'
        alias aptr='sudo port uninstall'
        alias aptp='sudo port clean --all'
        alias aptl='sudo port list'
        alias aptt='sudo port test'
        alias aptc='sudo port configure'
        alias aptd='sudo port fetch'
        alias apts='sudo port search'
        alias port='sudo port'
    fi
elif [ $IS_LINUX ]; 
then
    alias installed_packages='dpkg -l'                  # list all installed packets
    alias is_installed='dpkg -l | grep'                 # show if a package is installed
    alias edit_sources='sudo vi /etc/apt/sources.list'  # edit sources.list

    if [ -x /usr/bin/aptitude ]; 
    then
        # use Aptitude
        alias apti='sudo aptitude install'
        alias aptii='sudo aptitude install -y'
        alias aptu='sudo aptitude update'
        alias aptuu='sudo aptitude safe-upgrade'
        alias aptr='sudo aptitude remove'
        alias aptp='sudo aptitude purge'
        alias aptd='sudo aptitude download'
        alias apts='aptitude search'
    else
        # use apt-get
        alias apti='sudo apt-get install'
        alias aptii='sudo apt-get install -y'
        alias aptu='sudo apt-get update'
        alias aptuu='sudo apt-get upgrade'
        alias aptr='sudo apt-get remove'
        alias aptp='sudo apt-get purge'
        alias aptd='sudo apt-get download'
        alias apts='apt-cache search'
    fi
fi