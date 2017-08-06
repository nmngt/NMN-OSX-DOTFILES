# ----------------------------------------------------------------------------
#  BASH: Functions - Services
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Services Helper" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
	if [ -x "/Applications/MAMP/Library/bin/mysql" ]; 
	then

		function mqusedatabase ()
		{
			export MYSQL_DEFAULT_DB=$@
		}

		function mqrun ()
		{
			mysql -u root -t -D ${MYSQL_DEFAULT_DB} -vvv -e "$@" | highlight blue '[|+-]'
		}

		function mqrunfile ()
		{
			mysql -u root -t -vvv ${MYSQL_DEFAULT_DB} < $@ | highlight blue '[|+-]'
		}

		function mqrunfiletofile ()
		{
			mysql -u root -t -vvv ${MYSQL_DEFAULT_DB} < $1 >> $2
		}

		function mqrunfiletoeditor ()
		{
			mysql -u root -t -vvv ${MYSQL_DEFAULT_DB} < $1 | vim - 
		}

		function mqlistfields ()
		{
			mqrun "describe $@"
		}

		function mqcreatedatabase ()
		{
			mysqladmin -u root create $@
			echo "$@ Created" | highlight blue '.*'
		}

		function mqdropdatabase ()
		{
			echo Warning | highlight red '.*'
			mysqladmin -u root drop $@ 
		}
	fi
fi