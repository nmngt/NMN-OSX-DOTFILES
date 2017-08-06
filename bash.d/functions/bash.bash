# ----------------------------------------------------------------------------
#  BASH: Functions - BASH
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} BASH Helper" ${BASH_SOURCE}

# shows a man page with preview
#
function pman()
{
    if [ $IS_MAC ];
    then
        man -t "${1}" | open -fa $PREVIEW
    fi
}


# bash history durchsuchen
function hgrep()
{
    history | grep $1 | sed '$d'
}

function ls_funcs() 
{
    local ME=$(echo ${NBE_PATH}/bash.d/functions)
    if [ $# -eq 1 ]; then
        if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
            echo "Shows the functions availables in $ME and some information about this"
            return
        fi
    fi
    echo
    echo -e "--------------------------------------------------------------"
    echo -e " ${white}(NBE) Available functions: ${red}for infos, try '<funcname> -h'${nc}"
    echo -e "--------------------------------------------------------------"
    cat $ME | grep -n 'function' | cut -d '#' -f 1 | grep '()' | cut -d '(' -f 1
    echo
}

function ls_alias() 
{
    local ME=$(echo ${NBE_PATH}/bash.d/aliases)
    if [ $# -eq 1 ]; then
        if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
            echo "Shows the aliases availables in $ME and some information about this"
            return
        fi
    fi
    echo
    echo -e "--------------------------------------------------------------"
    echo -e " ${white}(NBE) Available aliases:${nc}"
    echo -e "--------------------------------------------------------------"
    cat $ME | grep -n 'alias' | cut -d '#' -f 1 | grep '='
    echo
}

# ---------------------------------------------------------------------------
#  ::: SPEED HISTORY ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# usage:  $ hi 4 ; will list last 4 commands
# (or:)   $ hi keyword ; will grep history for keyword
#
function hi()
{
    if [[ $1 =~ ^[0-9]+$ ]]; then
        command history | tail -n "$1";
    elif [ "$1" != "" ]; then
        command history | grep "$1";
    else
        command history | tail -20;
    fi
}

# ---------------------------------------------------------------------------
#  ::: HELPER ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# ...
function sum_lines() 
{
    paste -s -d+ | bc
}
