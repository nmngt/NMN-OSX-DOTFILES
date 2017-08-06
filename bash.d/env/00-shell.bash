# ----------------------------------------------------------------------------
#  Environment Variables: BASH related
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Shell" ${BASH_SOURCE}

# ---------------------------------------------------------------------------
#  ::: SETUP bash ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
export SHELL=${BASH}

# ---------------------------------------------------------------------------
#  ::: SETUP terminal ::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
export LINES=$(tput lines)	# terminal lines
export COLUMNS=$(tput cols) # terminal columns

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# ---------------------------------------------------------------------------
#  ::: SETUP bash_history ::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# Don't put duplicate lines in the history.
#export HISTCONTROL=erasedups ignoreboth
export HISTCONTROL="${HISTCONTROL}${HISTCONTROL+,}ignoredups"

# Ignore some controlling instructions: exit, ls, empty cd, pwd, date, help pages
HISTIGNORE_BASE=$'[ \t]*:&:[fb]g:exit:ls:ls -?::ls -??:ll:history:cd:cd -:cd ~:cd ..:..:pwd:date:* --help:* help'

# Ignore basic git commands
HISTIGNORE_GIT='git +([a-z]):git co -:git add -?:git pob -f:git pr -o:git undo .:git diff --staged'

# Ignore common local commands
HISTIGNORE_LOCAL='o:oo'

# Ignore common dev commands
HISTIGNORE_DEV='p:npm install:bower install'

# export combined HISTIGNORE
export HISTIGNORE=${HISTIGNORE}:${HISTIGNORE_BASE}:${HISTIGNORE_GIT}:${HISTIGNORE_LOCAL}:${HISTIGNORE_DEV}

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# format history with timestamp
# 319  | 2010-06-02 09:02PM | reload
export HISTTIMEFORMAT="| %F %I:%M%p | "
#export HISTTIMEFORMAT="%H:%M > "

# ---------------------------------------------------------------------------
#  ::: SETUP MANpages ::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------
# Don't clear the screen after quitting a manual page
export MANPAGER="less -iFXRS -x4"

# Highlight section titles in manual pages if possible
if tput setaf 1 &> /dev/null; then
	export LESS_TERMCAP_md="$(tput bold)$(tput setaf 33)"
fi

