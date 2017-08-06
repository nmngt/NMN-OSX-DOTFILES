# ----------------------------------------------------------------------------
#  BASH: Functions - GUI
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} CLI GUI Helper" ${BASH_SOURCE}


# ---------------------------------------------------------------------------
#  ::: MESSAGES ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

#: e_header()
function e_header() 
{ 
    printf "\n${bold}${purple}==========  %s  ==========${nc}\n" "$@" 
}

#: e_arrow()
function e_arrow() 
{ 
    printf "➜ $@\n"
}

#: e_success()
function e_success() 
{ 
    printf "${green}✔ %s${nc}\n" "$@"
}

#: e_error()
function e_error() 
{ 
    printf "${red}✖ %s${nc}\n" "$@"
}

#: e_warning()
function e_warning() 
{ 
    printf "${brown}➜ %s${nc}\n" "$@"
}

#: e_underline()
function e_underline() 
{ 
    printf "${underline}${bold}%s${nc}\n" "$@"
}

#: e_bold()
function e_bold() 
{ 
    printf "${bold}%s${nc}\n" "$@"
}

#: e_note()
function e_note() 
{ 
    printf "${underline}${bold}${blue}Note:${nc}  ${blue}%s${nc}\n" "$@"
}

# ---------------------------------------------------------------------------
#  ::: (G)UI :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ---------------------------------------------------------------------------

# 
function msg()
{
    if [ -f "$(which dialog)" ]; then
        if [ $# < 2 ]; then
            dialog --msgbox "$1" 0 0
        else
            dialog --msgbox "$1" $2 $3
        fi
        clear
    else 
        e "$1"
    fi
}





# Helper function to print a debug message to STDOUT
function dbg()
{
	if [ -n "${NMN_DEBUG_MESSAGE_COUNTER:+x}" ]; then 
		export NMN_DEBUG_MESSAGE_COUNTER=1
	else
		let NMN_DEBUG_MESSAGE_COUNTER=${NMN_DEBUG_MESSAGE_COUNTER}+1
		export $NMN_DEBUG_MESSAGE_COUNTER
	fi
	echo -e "\n${white}(${nc}${red}${NMN_DEBUG_MESSAGE_COUNTER}${nc}${white})${nc} ${green}${1}${nc}"
}

# generic confirmation function
function confirm() 
{
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Create a horizontal rule, hr style
function hr() 
{
    # set -f
    [[ -n $1 ]] && space_character=$( echo "$1" | head -c 1) || space_character='='

    for i in $(seq 1 "$(tput cols)");
    do
        echo -n "${space_character}";
    done
    echo ""
}