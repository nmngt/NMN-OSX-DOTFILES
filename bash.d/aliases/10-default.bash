# ----------------------------------------------------------------------------
#  BASH: Aliases - Defaults
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------

# ---------------------------------------------------------------------------
#  ::: HACKS & HELPERS :::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
nbe_msg "${icon[child]} Default" ${BASH_SOURCE}

#: ugly hack! but w/o visudo doens'nt work on Darwin
alias visudo='sudo'

#: alias to show me the shell commands i recently use
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

#: alias to reload my BASH environment
if [ $IS_MAC ];
then
	alias reload='source ~/.bash_profile && source ~/.bash/aliases'
else
	alias reload='source ~/.profile && source ~/.bash/aliases'
fi

# ---------------------------------------------------------------------------
#  ::: DEFAULTS ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

#: shortcuts
alias m='more'
alias j='jobs -l'
alias h='history'

#: dir shortcuts
alias n="cd $HOME/nzb/"
alias s="cd $HOME/Sites/"

#: change dir
# alias .="cwd"
# alias ..="cd .."
# alias ...="cd .. ; cd .."
# alias ....="cd .. ; cd .. ; cd .."
# alias cd..="cd .."
alias cwd="echo $PWD"

#: colorized listing commands
alias l='ls -CF ${LS_OPTIONS}'
alias ll='ls -lah ${LS_OPTIONS}'		# my default listing command :-)
alias la='ls -Al ${LS_OPTIONS}'			# show hidden files
alias ls='ls -hF ${LS_OPTIONS}'			# add colors for filetype recognition
alias lx='ls -lXB ${LS_OPTIONS}'		# sort by extension
alias lk='ls -lSr ${LS_OPTIONS}'		# sort by size
alias lc='ls -lcr ${LS_OPTIONS}'		# sort by change time
alias lu='ls -lur ${LS_OPTIONS}'		# sort by access time
#alias lr='ls -lR ${LS_OPTIONS}'		# recursive ls
alias lt='ls -ltr ${LS_OPTIONS}'		# sort by date
alias lm='ls -al ${LS_OPTIONS} |more'	# pipe through 'more'
#alias tree='tree -Csu'					# nice alternative to 'ls'
alias recent='ls -lAt | head'			# show recent files
alias old='ls -lAt | tail'				# show old files

# lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less' 


#: show file space usage with human readable output
alias df='df -h'
alias du='du -h'
alias duh="du -h --max-depth=1"
alias duhh='du -cks * | sort -rn | head -11'
alias ducks='du -cks * | sort -rn|head -11'		# Lists the size of all the folders and files

#: file permission aliases
alias mx='chmod a+x'
# alias 000='chmod 000'
# alias 644='chmod 644'
# alias 755='chmod 755'
# alias 775='chmod 775'
alias chmodx='chmod +x'
#alias chmod775='chmod -R 775'
alias chownweb='chown -R www-data:www-data'

# topForever: Continual 'top' listing (every 10 seconds)
alias topForever='top -l 9999999 -s 10 -o cpu'

# ttop:  Recommended 'top' invocation to minimize resources
# (http://www.macosxhints.com/article.php?story=20060816123853639)
alias ttop="top -R -F -s 10 -o rsize"

#: xterm and aterm related
# alias term='xterm -bg AntiqueWhite -fg Black &'
# alias aterm='aterm -ls -fg gray -bg black'
# alias termb='xterm -bg AntiqueWhite -fg NavyBlue &'
# alias termg='xterm -bg AntiqueWhite -fg OliveDrab &'
# alias termr='xterm -bg AntiqueWhite -fg DarkRed &'
# alias xterm='xterm -fb "" -bg black -fg gray -fa "Sans Mono" -fs 10 +sb -sl 3000 -g 80x50+1+1'
# alias xtop='xterm -fn 6x13 -bg LightSlateGray -fg black -e top &'
# alias xsu='xterm -fn 7x14 -bg DarkOrange4 -fg white -e su &'

#: ncurses enhancements / beautifier 
#alias top='xtitle Processes on $HOST && top'
#alias make='xtitle Making $(basename $PWD) ; make'
alias news='xterm -g 80x45 -e trn -e -S1 -N &'
# alias background='xv -root -quit -max -rmode 5'

#: allow which command to expand
if which --tty-only which > /dev/null 2>&1; then
	alias which="alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde"
fi

#: tail
alias tailf='tail -f'
[ $IS_LINUX ] && alias t='tailf /var/log/syslog' || alias t='tailf /var/log/system.log'

#: grep
alias g='grep ${GREP_OPTIONS} -i'
alias grep="LANG=C grep ${GREP_OPTIONS}"
alias egrep="egrep --color=always"

#: less (raw control characters)
alias less='less -r'

#: cat (print linenumbers)
alias catn='cat -n'

# cal (shows 3 months by default)
alias cal='cal -3'

# diff (normalize for distribution)
alias diff='LC_ALL=C TZ=GMT0 diff -Naur'

# lynx (with best settings for viewing html)
alias lynx="lynx -force_html -width=${COLUMNS}"

#: lsof
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u"

# open ncftp
alias ncftp="xtitle ncFTP ; ncftp"

#: Show environment variables
# alias ?="printenv | sort | less"

#: process related
if [ $IS_LINUX ]; 
then 
	alias proc_all='ps -alx'
else 
	alias top='top -o cpu'
fi

