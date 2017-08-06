# ----------------------------------------------------------------------------
#  BASH: Functions - Files
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Files Helper" ${BASH_SOURCE}

# cdf:  'Cd's to frontmost window of MacOS Finder
function cdf() 
{
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}


# ---------------------------------------------------------------------------
#  ::: LINKS/ALIASES :::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# make link - I can never remember which way round symlinks go
function mln() 
{
    echo "This will create a symlink from <name> -> <actual-file>."
    local target
    local name
    read -p "  Enter actual file:  " target
    read -p "  Enter name of link: " name

    echo "Creating symlink $name -> $target"

    ln -s $target $name
}

# ---------------------------------------------------------------------------
#  ::: FILES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# open shortcut
function o() 
{ 
    command open "$@" >/dev/null;
}

# Switches two files contents
function switch() 
{
    mv "$1" "$1_orig" &&
    mv "$2" "$1" &&
    mv "$1_orig" "$2"
}

# Move file to a backup ".old" version
function old() 
{
    mv "$1"{,.old}
}

# Determine size of a file or total size of a directory
function fs() 
{
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}

# Get gzipped file size
function gzsize() {
    echo -n "original (bytes): "
    cat "${1}" | wc -c
    echo -n "gzipped (bytes):  "
    gzip -c "${1}" | wc -c
}

# ---------------------------------------------------------------------------
#  ::: FOLDERS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Create a new directory and enter it
function md() 
{
    mkdir -p "$@" && cd "$@"
}

#: create a directory and cd into it
function mkcd () 
{ 
    mkdir -p "$@" && eval cd "\"\$$#\""; 
}

#: copies all files from subfolders to the parent/target-fodler
# function flatten_subfolders()
# {
#     find ${1} -mindepth 2 -type f -exec mv -i '{}' ${1} ';'
# }

# ---------------------------------------------------------------------------
#  ::: FIND ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Count the number of files in a directory
function cf() 
{
    find "${1-.}" -type f | wc -l
}

# find files with case-insensetive matching in current directory
function findhere() 
{
    find . -iname "*$1*"
}

# do a case-insensetive grep on all the files in a directory
function grip() 
{
    grep -ir "$1" .
}

# ---------------------------------------------------------------------------
#  ::: LIST ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

#: LS - Listing pretty-printer
function lll ()
{
    ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; 
}


# ---------------------------------------------------------------------------
#  ::: EXTRACTION ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

function extract() 
{
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf "$1"     ;;
            *.tar.gz)    tar xvzf "$1"     ;;
            *.bz2)       bunzip2 "$1"      ;;
            *.rar)       unrar x "$1"      ;;
            *.gz)        gunzip "$1"       ;;
            *.tar)       tar xvf "$1"      ;;
            *.tbz2)      tar xvjf "$1"     ;;
            *.tgz)       tar xvzf "$1"     ;;
            *.zip)       unzip "$1"        ;;
            *.Z)         uncompress "$1"   ;;
            *.7z)        7z x "$1"         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


