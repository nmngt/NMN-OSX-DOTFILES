# ----------------------------------------------------------------------------
#  Environment Variables: Localization
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Localization" ${BASH_SOURCE}

#
# language
#
export LANG=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8

#
# localization
#
export LC_CTYPE=de_DE.UTF-8
export LC_NUMERIC=de_DE.UTF-8
export LC_TIME=de_DE.UTF-8
export LC_COLLATE=de_DE.UTF-8
export LC_MONETARY=de_DE.UTF-8
export LC_MESSAGES=de_DE.UTF-8
export LC_PAPER=de_DE.UTF-8
export LC_NAME=de_DE.UTF-8
export LC_ADDRESS=de_DE.UTF-8
export LC_TELEPHONE=de_DE.UTF-8
export LC_MEASUREMENT=de_DE.UTF-8
export LC_IDENTIFICATION=de_DE.UTF-8

#
# timezone
#
export TZ='Europe/Berlin'

#
# timeformat
#
if [ $IS_MAC ]; 
then
	export TIMEFORMAT=$'\nreal\t%3lR\nuser\t%3lU\nsys%3lS'
elif [ $IS_LINUX ]; 
then
	export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
fi
