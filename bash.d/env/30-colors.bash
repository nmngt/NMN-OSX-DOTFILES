# ----------------------------------------------------------------------------
#  BASH: Colors
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
# color definition for mac/bsd:
#   a = black | b = red | c = green | d = brown | e = blue | f = magenta
#   g = cyan | h = light grey | A = bold black | B = bold red
#   C = bold green | D = bold brown | E = bold blue | F = bold magenta
#   G = bold cyan | H = bold light grey | x = default foreground or background
#
#   1. directory | 2. symbolic link | 3. socket | 4. pipe | 5. executable
#   6. block special | 7. character special | 8. executable with setuid bit
#   9. executable with setgid bit | 10. dir writable to others, with sticky
#   11. dir writable to others, without sticky bit
# ----------------------------------------------------------------------------
nbe_msg "Setup color definitions" ${BASH_SOURCE}

# force TERM to xterm-color
#export TERM=xterm-color

# test if $TERM supports colors
case "$TERM" in
    xterm-color|xterm-256color) color_are_supported=yes;;
esac

# if $TERM doesnt support colors, return
[ -z "$color_are_supported" ] && return || unset colors_are_supported

# set colors for files and filetypes
case "$OS" in
	darwin*|*bsd*)
		export CLICOLOR=1
		export LSCOLORS='ExCxhxdxbxegedabaghbag'
		export LS_COLORS='ExCxhxdxbxegedabaghbag'
		;;
	linux*)
		if [ -x /usr/bin/dircolors ]; 
		then
			if [ ! -f ~/.dircolors ]; 
			then
				dircolors --print-database > ~/.dircolors
			fi
			test -r ~/.dircolors && \
				eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
		else
			export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'
		fi
		;;
	*)
		;;
esac

if [ -x /usr/bin/dircolors ]; 
then
	export LS_OPTIONS='--color=auto'
	export GREP_OPTIONS='--color=auto' 
	export GREP_COLOR='1;32' # or 1;37;41
fi

# set nice alias to check all colors currently set
alias colorslist="set | egrep 'COLOR_\w*'"



