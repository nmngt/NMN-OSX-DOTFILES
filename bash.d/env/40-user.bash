# ----------------------------------------------------------------------------
#  Environment Variables: User Related Vars
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} User" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: USER VARS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
export USER=$(id -un)
export USERNAME=$USER
export GROUP=$(id | sed 's/.* gid=[0-9]*(\([^)]*\)).*/\1/')

#export UMASK=
#export UMASK_DIR=

#
# Set user details
#
case ${USER} in
	norm*|blah*)
		export EMAIL="norm@ngeorg.com"
		export COMPANY="NGT"
		export COMPANY_URL="https://georg-tusel.com"
		;;
	#akem*|achim*)
	#	export EMAIL="a.draeger@internet-marketing-agentur.com"
	#	export COMPANY="Internet-Marketing-Agentur"
	#	export COMPANY_URL="http://www.internet-marketing-agentur.com"
	#	;;
	root)
		export EMAIL="root@${FQDN}"
		export COMPANY_URL="http://${FQDN}"
		;;
	*)
		export EMAIL="${USER}@${FQDN}"
		export COMPANY_URL="http://${FQDN}"
		;;
esac

# ---------------------------------------------------------------------------
#  ::: MAILDIR :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
if [ -d "~/Maildir" ]; 
then
    export MAIL="~/Maildir" 
	export MAILPATH=${MAIL} 
	export MAILDIR=${MAIL}
elif [ -f "/var/mail/${USER}" ]; 
then
    export MAIL="/var/mail/$USER"
	if [ -d "/var/vmail/${USER}" ]; 
	then 
		export VMAIL="/var/vmail/${USER}" ;
	fi
fi

