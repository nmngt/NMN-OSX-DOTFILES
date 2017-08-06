#!/usr/bin/env bash
# ----------------------------------------------------------------------------
#  BASH: Bash Completions
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
#nbe_msg "${icon_child} Default/System" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: SSH-HOSTS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
#
# OLD VERSION
#
if [[ -e "${HOME}/.ssh/known_hosts" ]]; then
 complete -o default -W "$(cat "${HOME}/.ssh/known_hosts" | sed 's/[, ].*//' | tr -d '[]' | sed 's/:[0-9]\+$//' | sort | uniq)" ssh
fi
#
# NEW VERSION
#
# _ssh_hosts() {
#   grep "Host " ~/.ssh/config 2> /dev/null | sed -e "s/Host //g"
#   # http://news.ycombinator.com/item?id=751220
#   if [ -f "$HOME/.ssh/known_hosts" ]; then
#     cut -f 1 -d ' ' < "$HOME/.ssh/known_hosts" | sed -e s/,.*//g | uniq | grep -v "\["
#   fi
# }
# complete -W "$(_ssh_hosts)" ssh

# ---------------------------------------------------------------------------
#  ::: SUDO ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# complete sudo commands
complete -cf sudo