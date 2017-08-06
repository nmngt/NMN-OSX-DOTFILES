# ----------------------------------------------------------------------------
#  Environment Variables: Applications
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Applications" ${BASH_SOURCE}


# ---------------------------------------------------------------------------
#  ::: DEFAULT Text Editor :::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
#export EDITOR="${EDITOR:-$(type vim &> /dev/null && echo vim || echo vi)}"
export EDITOR='/usr/bin/vim'
export PREVIEW="less"

if [ $IS_MAC ];
then
	[[ -x "/usr/local/bin/subl" ]] && EDITOR="subl"
	PREVIEW="/Applications/Preview.app"
fi

#: default visual editor
export VISUAL=${EDITOR}

# ---------------------------------------------------------------------------
#  ::: RAR :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
#export RAR='-s -md1024'

# ---------------------------------------------------------------------------
#  ::: NVM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# (https://github.com/creationix/nvm#install-script)
#
if [ -d "$HOME/.nvm" ]; 
then
	export NVM_DIR="$HOME/.nvm"

	# This loads nvm
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

	# This loads nvm bash_completion
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# ---------------------------------------------------------------------------
#  ::: MySQL :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# Available Environment Variables
#
#   CXX					The name of your C++ compiler (for running configure).
#   CC					The name of your C compiler (for running configure).
#   CFLAGS				Flags for your C compiler (for running configure).
#   CXXFLAGS			Flags for your C++ compiler (for running configure).
#   DBI_USER			The default user name for Perl DBI.
#   DBI_TRACE			Trace options for Perl DBI.
#   LD_RUN_PATH			Used to specify the location of libmysqlclient.so.
#   MYSQL_DEBUG			Debug trace options when debugging.
#   MYSQL_GROUP_SUFFIX	Option group suffix value (like specifying --defaults-group-suffix).
#   MYSQL_HISTFILE		The path to the mysql history file. If set, it overrides $HOME/.mysql_history.
#   MYSQL_HOME			The path to the directory in which the server-specific my.cnf file resides.
#   MYSQL_HOST			The default host name used by the mysql command-line client.
#   MYSQL_PS1			The command prompt to use in the mysql command-line client.
#   MYSQL_PWD			The default password when connecting to mysqld. 
#   MYSQL_TCP_PORT		The default TCP/IP port number.
#   MYSQL_UNIX_PORT		The default Unix socket file name; used for connections to localhost.
#
export MYSQL_HOST="localhost"
export MYSQL_TCP_PORT=3306
export MYSQL_DEFAULT_DB=mysql
export MYSQL_PS1="[\R:\m]\_\u\_\d\_$>\_"

#
# set MySQL UNIX port/socket
#
if [ $IS_LINUX ]; 
then
	export MYSQL_UNIX_PORT=/var/run/mysqld/mysqld.sock
elif [ $IS_MAC ]; 
then
	export MYSQL_UNIX_PORT=/Applications/MAMP/tmp/mysql/mysql.sock
fi


