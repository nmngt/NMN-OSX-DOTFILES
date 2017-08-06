# ----------------------------------------------------------------------------
#  BASH: Functions - Images
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Image Helper" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: PNGCRUSH ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# usage:  $ cd dir_with_images && png dir_to_save_new_images
# or:     $ cd dir_with_images && png ; will save images to ../crushedimages
#
function png()
{
    if [ "$1" != "" ]; 
    then
        command pngcrush -d "../$1" *.png;
    else
        command pngcrush -d "../crushedimages" *.png;
    fi
}

# ---------------------------------------------------------------------------
#  ::: IMG META DATA :::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# image metadata from web
function imgmeta() 
{
	curl -sr 0-1024 "$@" |strings
}

# ---------------------------------------------------------------------------
#  ::: RETURN DATA URL :::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# Create a data URL from an image (works for other file types too, if you 
# tweak the Content-Type afterwards)
#
function dataurl() 
{
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; 
	then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}