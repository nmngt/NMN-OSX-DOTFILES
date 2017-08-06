# ----------------------------------------------------------------------------
#  BASH: Functions - UTF8
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} UTF-8 Helper" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: UTF-8 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Escape UTF-8 characters into their 3-byte format
function escape() 
{
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() 
{
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

# Get a character's Unicode code point
function codepoint() 
{
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    echo # newline
}