# ----------------------------------------------------------------------------
#  BASH: Functions - PATH
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
#
# Each of these functions can take an optional final argument, naming the 
# environment variable to operate on. The default environment variable is PATH, 
# of course.
#
# Source: https://github.com/ingydotnet/path-manip-sh
# 
# Usage:
#    path-list [<variable>]:
#    List all the components of a PATH variable, one per line
#
#    path-remove <component> [<variable>]:
#    Remove specified component from a PATH variable
#
#    path-prepend <component> [<variable>]:
#    Add component to beginning of a PATH (after removing any instances of it)
#
#    path-append <component> [<variable>]:
#    Add component to end of PATH (after removing any instances of it)
#
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} PATH Helper" ${BASH_SOURCE}

# List each directory in your PATH, one per line
function path-list() 
{
    local path
    local d
    if [ "$#" -eq 1 ]; then eval path=\$$1; else path="$PATH"; fi
    for d in `echo $path | sed -e 's/:/ /g'`; do
        echo "$d"
    done
}

# Remove a directory from your PATH
function path-remove() 
{
    local path
    local d
    local p=""
    if [ "$#" -eq 2 ]; then eval path=\$$2; else path="$PATH"; fi
    for d in `echo $path | sed -e 's/:/ /g'`; do
        if [ "$d" != "$1" ]; then
            if [ "$p" = "" ]; then
                p="$d"
            else
                p="$p:$d"
            fi
        fi
    done
    if [ "$#" -eq 2 ]; then eval $2=\$p; else PATH="$p"; fi
}

# Add a directory to the start of your PATH while removing old references.
function path-prepend() 
{
    local path
    path-remove $*
    if [ "$#" -eq 2 ]; then eval path=\$$2; else path="$PATH"; fi
    path="$1:$path"
    if [ "$#" -eq 2 ]; then eval "$2=$path"; else PATH="$path"; fi
}

# Add a directory to the end of your PATH while removing old references.
function path-append() 
{
    local path
    path-remove $*
    if [ "$#" -eq 2 ]; then eval path=\$$2; else path="$PATH"; fi
    path="$path:$1"
    if [ "$#" -eq 2 ]; then eval $2=\$path; else PATH="$path"; fi
}

# Copyright © 2011 Ingy dot Net <ingy@ingy.net>
# 
# This library is free software, distributed under the ISC License.
# See the LICENSE file distributed with this library.