# ----------------------------------------------------------------------------
#  BASH: Aliases - Applications
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Applications" ${BASH_SOURCE}

if [ $IS_MAC ]; 
then
	# ---------------------------------------------------------------------------
	#  ::: TextMate ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	if [ -x "~/bin/mate" ];
	then
		nbe_msg "${icon[child]} - Textmate" ${BASH_SOURCE}
		alias tm='mate .'
		alias m='~/bin/mate -r'
		alias mw='~/bin/mate -rw'
		alias matew='~/bin/mate -rw'
		alias rc='mate -w ~/.bash_profile && echo "Sourcing ~/.bash_profile" && source ~/.bash_profile'
		alias rtm="mate app config db lib public spec"
		alias bashrc='mate ~/.bash_profile && echo "Sourcing ~/.bash_profile" && source ~/.bash_profile'
		alias bundle='cd /Library/Application\ Support/TextMate/ && svn up'
	fi

	# ---------------------------------------------------------------------------
	#  ::: Firefox :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	if [ -x "/Applications/Firefox.app/Contents/MacOS/firefox-bin" ];
	then
		nbe_msg "${icon[child]} - Firefox" ${BASH_SOURCE}
		alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox-bin -no-remote -P developer &'
		alias ff='open -a firefox'
	fi

	# ---------------------------------------------------------------------------
	#  ::: UnRarX ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	# (alias for use unrar from UnRarX Application instead of /bin/unrar)
	if [ -x "/Applications/UnRarX.app/Contents/Resources/unrar" ];
	then
		nbe_msg "${icon[child]} - UnRarX" ${BASH_SOURCE}
		alias unrar="/Applications/Utilities/UnRarX.app/Contents/Resources/unrar"
	fi

	# ---------------------------------------------------------------------------
	#  ::: VLC Player ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	if [ -x "/Applications/VLC.app/Contents/MacOS/VLC" ];
	then
		nbe_msg "${icon[child]} - VLC" ${BASH_SOURCE}
		alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
	fi

	# ---------------------------------------------------------------------------
	#  ::: PHP Composer ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	# if [ -x "/opt/local/bin/composer.phar" ]; 
	# then
	# 	nbe_msg "${icon[child]} - Composer" ${BASH_SOURCE}
	# 	alias composer="php /opt/local/bin/composer.phar"
	# fi

	# ---------------------------------------------------------------------------
	#  ::: MAMP (PRO) ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	# if [ -d "/Applications/MAMP" ]; 
	# then
	# 	nbe_msg "${icon[child]} - MAMP" ${BASH_SOURCE}
	# 	#: MAMP Aliases
	# 	alias php='/Applications/MAMP/bin/php/php7.0.20/bin/php -c "/Library/Application Support/appsolute/MAMP PRO/conf/php7.0.20.ini"'
	# 	alias pear='/Applications/MAMP/bin/php/php7.0.20/bin/pear'
	# 	alias pecl='/Applications/MAMP/bin/php/php7.0.20/bin/pecl'
	# 	alias mysql='/Applications/MAMP/Library/bin/mysql --host=localhost'

	# 	#: mamp-cli
	# 	# https://www.npmjs.com/package/mamp-cli
	# fi

	# ---------------------------------------------------------------------------
	#  ::: PHP :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	alias pserve="php -S 0.0.0.0:8000"				# Serve PHP site

	# ---------------------------------------------------------------------------
	#  ::: personal WIKI :::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	alias wiki="cd ~/Documents/wiki; subl ."		# Write a personal wiki

	# ---------------------------------------------------------------------------
	#  ::: EMACS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	# ---------------------------------------------------------------------------
	if [ -d "/Applications/Emacs.app" ]; 
	then
	    alias emacs='open -a /Applications/Emacs.app/'
	else
	    alias emacs='vim'
	fi

fi


# ---------------------------------------------------------------------------
#  ::: LARAVEL :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# A list of useful laravel aliases

alias laravel="/home/${USER}/.composer/vendor/bin/laravel"
# asset
alias a:apub='php artisan asset:publish'

# auth
alias a:remclear='php artisan auth:clear-reminders'
alias a:remcontroller='php artisan auth:reminders-controller'
alias a:remtable='php artisan auth:reminders-table'

# cache
alias a:cacheclear='php artisan cache:clear'

# command
alias a:command='php artisan command:make'

# config
alias a:confpub='php artisan config:publish'

# controller
alias a:controller='php artisan make:controller'

# db
alias a:seed='php artisan db:seed'

# key
alias a:key='php artisan key:generate'

# migrate
alias a:migrate='php artisan migrate'
alias a:mig='a:migrate'
alias a:miginstall='php artisan migrate:install'
alias a:migmake='php artisan migrate:make'
alias a:migcreate='php artisan migrate:create'
alias a:migpublish='php artisan migrate:publish'
alias a:migrefresh='php artisan migrate:refresh'
alias a:migreset='php artisan migrate:reset'
alias a:migrollback='php artisan migrate:rollback'
alias a:rollback='a:migrollback'

# queue
alias a:qfailed='php artisan queue:failed'
alias a:qfailedtable='php artisan queue:failed-table'
alias a:qflush='php artisan queue:flush'
alias a:qforget='php artisan queue:forget'
alias a:qlisten='php artisan queue:listen'
alias a:qretry='php artisan queue:retry'
alias a:qsubscribe='php artisan queue:subscribe'
alias a:qwork='php artisan queue:work'

# session
alias a:stable='php artisan session:table'

# view
alias a:vpub='php artisan view:publish'

# misc
alias a:='php artisan'
alias a:changes='php artisan changes'
alias a:down='php artisan down'
alias a:env='php artisan env'
alias a:help='php artisan help'
alias a:list='php artisan list'
alias a:optimize='php artisan optimize'
alias a:routes='php artisan routes'
alias a:serve='php artisan serve'
alias a:tail='php artisan tail'
alias a:tinker='php artisan tinker'
alias a:up='php artisan up'
alias a:work='php artisan workbench'









