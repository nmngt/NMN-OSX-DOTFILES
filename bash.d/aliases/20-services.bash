# ----------------------------------------------------------------------------
#  BASH: Aliases - Services
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Services" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: APACHE2 :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
if [ $IS_LINUX ]; 
then
	if [ -x "/etc/init.d/apache2" ]; 
	then
		nbe_msg "${icon_child} - Apache2" ${BASH_SOURCE}

		alias a2r="restart apache2"
		alias a2fr='service apache2 force-reload'
		alias a2status='service apache2 status'

		#: Returns all domains from apache configuration file
		#function a2domains {
		#	cat 00[123]* | egrep -i "ServerAlias|ServerName" | egrep -iv '#|server-center'&nbsp; | sed 's/ServerAlias//' | sed 's/ServerName//' | sed 's/www.//' | sed 's/*.//' | sed 's/ //'&nbsp; | sort | uniq
		#}
	fi
fi

# ---------------------------------------------------------------------------
#  ::: MySQL :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
if [ $IS_LINUX ]; 
then
	if [ -x "/etc/init.d/mysql" ]; 
	then
		nbe_msg "${icon_child} - MySQL" ${BASH_SOURCE}
		
		alias dbs="mysql -u root -p"
		alias mysql="mysql -u root -p"
		alias mqlistdatabases='mqrun "show databases"'
		alias mqlisttables='mqrun "show tables"'
		
		#: show differences colorized
		alias mqshowcommands="echo -e '${purple}Available commands: 
		   ${blue}mq${nc}list${blue}databases${nc}
		   ${blue}mq${nc}use${blue}database${nc}
		   ${blue}mq${nc}create${blue}database${nc}
		   ${blue}mq${nc}drop${blue}database${nc}
		   ${blue}mq${nc}list${blue}tables${nc}
		   ${blue}mq${nc}list${blue}fields${nc}
		   ${blue}mq${nc}run              ${grey}Example: mqrun \"Select id From foo\"
		   ${blue}mq${nc}run${blue}file${nc}          ${grey}Example: mqrunfile file_name
		   ${blue}mq${nc}run${blue}file${nc}to${blue}file${nc}    ${grey}Example: mqrunfiletofile file_name out_file_name
		'"
	fi
fi