#!/usr/bin/env bash
# ----------------------------------------------------------------------------
#  BASH: Prompt
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} nbe_prompt PlugIn" ${BASH_SOURCE}

# exit for non-interactive
[[ -z $PS1 ]] && return

#
# cli configuration for NBE prompt
#
function nbeprompt() 
{
  case "$1" in
    reload) source ~/.bashrc ;;
    prompt)
      case "$2" in
        on|off|system) export PROMPT_COMMAND="__nbe_prompt_ps1 $2" ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    config)
      case "$2" in
        default|load|save) __nbe_prompt_config $2 ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    py)
      case "$2" in
        virtualenv)
          case "$3" in
            on|off|auto) 
                if [ $IS_BASH4 ];
                then
                    export "NBE_PROMPT_${1^^}_${2^^}"="$3"
                else
                    local arg1=$(echo ${1} | upper)
                    local arg1=$(echo ${2} | upper)
                    export "NBE_PROMPT_${arg1}_${arg2}"="$3" 
                fi
                ;;
          esac
          ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    user|git|jobs|symbol|rc)
      case "$2" in
        on|off) 
            if [ $IS_BASH4 ];
            then
                export "NBE_PROMPT_${1^^}"="$2" 
            else
                local arg1=$(echo ${1} | upper)
                export "NBE_PROMPT_${arg1}"="$2" 
            fi
            ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    host)
      case "$2" in
        on|off|auto) 
            if [ $IS_BASH4 ];
            then
                export "NBE_PROMPT_${1^^}"="$2" 
            else
                local arg1=$(echo ${1} | upper)
                export "NBE_PROMPT_${arg1}"="$2"
            fi
            ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    path)
      case "$2" in
        off|full|working|parted|mini) 
            if [ $IS_BASH4 ];
            then
                export "NBE_PROMPT_${1^^}"="$2" 
            else
                local arg1=$(echo ${1} | upper)
                export "NBE_PROMPT_${arg1}"="$2" 
            fi
            ;;
        short)
            if [ $IS_BASH4 ];
            then
                export "NBE_PROMPT_${1^^}"="$2"
            else
                local arg1=$(echo ${1} | upper)
                export "NBE_PROMPT_${arg1}"="$2"
            fi
            case "$3" in
                add|subtract) __nbe_prompt_path_short_length $3 $4 ;;
            esac
            ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    term)
      case "$2" in
        xterm|xterm-256color|screen|screen-256color) export "TERM"="$2" ;;
        *) e_error "invalid option" ;;
      esac
    ;;
    *) e_error "no option given" ;;
  esac
}

#
#
#
__nbe_prompt_complete() 
{
  local cur prev option_list
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [ $COMP_CWORD -eq 1 ]; 
  then
    # first level options
    option_list="reload prompt config py user host path git jobs symbol rc term"
  elif [ $COMP_CWORD -eq 2 ]; 
  then
    # second level options
    case "${prev}" in
      prompt) option_list="on off system" ;;
      config) option_list="default load save" ;;
          py) option_list="virtualenv" ;;
        user) option_list="on off" ;;
        host) option_list="on off auto" ;;
        path) option_list="off full working short parted mini" ;;
         git) option_list="on off" ;;
        jobs) option_list="on off" ;;
      symbol) option_list="on off" ;;
          rc) option_list="on off" ;;
        term) option_list="xterm xterm-256color screen screen-256color" ;;
    esac
  elif [ $COMP_CWORD -eq 3 ]; 
  then
    # third level options
    case "${prev}" in
      virtualenv) option_list="on off auto" ;;
      short) option_list="add subtract" ;;
    esac
  fi
  COMPREPLY=( $(compgen -W "${option_list}" -- ${cur}) )
}

#
#
#
__nbe_prompt() 
{
  # define variables
  NBE_PROMPT_ICONS=( "⚑" "»" "♆" "☀" "♞" "☯" "☢" "❄" "+" "▶" )
  NBE_PROMPT_ARROWS=( "⇠" "⇡" "⇢" "⇣" )
  NBE_PROMPT_PY_VIRTUALENV_SYMBOL=${NBE_PROMPT_ICONS[9]}
  NBE_PROMPT_GIT_BRANCH_SYMBOL=${NBE_PROMPT_ICONS[1]}
  NBE_PROMPT_GIT_BRANCH_CHANGED_SYMBOL=${NBE_PROMPT_ICONS[8]}
  NBE_PROMPT_GIT_NEED_PUSH_SYMBOL=${NBE_PROMPT_ARROWS[1]}
  NBE_PROMPT_GIT_NEED_PULL_SYMBOL=${NBE_PROMPT_ARROWS[3]}
  DIM="\[$(tput dim)\]"
  REVERSE="\[$(tput rev)\]"
  RESET="\[$(tput sgr0)\]"
  BOLD="\[$(tput bold)\]"

  __nbe_prompt_config() 
  {
    case "$1" in
      default)
        [ -e "${NBE_PROMPT_CONFIG}" ] && rm ${NBE_PROMPT_CONFIG}
        while read -r param; do
          unset "${param}"
        done <<< "`env | grep \"NBE_PROMPT_\" | sed \"s/=.*//g\"`"
        ;;
      load)
        if [ -e "${NBE_PROMPT_CONFIG}" ]; 
        then
          while read p; do
            export $p
          done < ${NBE_PROMPT_CONFIG}
        fi
        ;;
      save)
        echo -n "" > ${NBE_PROMPT_CONFIG}
        env | grep "NBE_PROMPT_" >> ${NBE_PROMPT_CONFIG}
        ;;
    esac
  }

  __nbe_prompt_colors() 
  {
    if (( $(tput colors) < 256 )); 
    then
      # 8 color support
      COLOR_USER="\[$(tput setaf 7)\]\[$(tput setab 0)\]"
      COLOR_SUDO="\[$(tput setaf 3)\]\[$(tput setab 0)\]"
      COLOR_SSH="\[$(tput setaf 3)\]\[$(tput setab 0)\]"
      COLOR_DIR="\[$(tput setaf 7)\]\[$(tput setab 0)\]"
      COLOR_GIT="\[$(tput setaf 7)\]\[$(tput setab 4)\]"
      COLOR_RC="\[$(tput setaf 7)\]\[$(tput setab 1)\]"
      COLOR_JOBS="\[$(tput setaf 7)\]\[$(tput setab 5)\]"
      COLOR_SYMBOL_USER="\[$(tput setaf 7)\]\[$(tput setab 2)\]"
      COLOR_SYMBOL_ROOT="\[$(tput setaf 7)\]\[$(tput setab 1)\]"
    else
      # 256 color support
      COLOR_USER="\[$(tput setaf 15)\]\[$(tput setab 8)\]"
      COLOR_SUDO="\[$(tput setaf 3)\]\[$(tput setab 8)\]"
      COLOR_SSH="\[$(tput setaf 3)\]\[$(tput setab 8)\]"
      COLOR_DIR="\[$(tput setaf 7)\]\[$(tput setab 8)\]"
      COLOR_GIT="\[$(tput setaf 15)\]\[$(tput setab 4)\]"
      COLOR_RC="\[$(tput setaf 15)\]\[$(tput setab 9)\]"
      COLOR_JOBS="\[$(tput setaf 15)\]\[$(tput setab 5)\]"
      COLOR_PY_VIRTUALENV="\[$(tput setaf 15)\]\[$(tput setab 5)\]"
      COLOR_SYMBOL_USER="\[$(tput setaf 15)\]\[$(tput setab 2)\]"
      COLOR_SYMBOL_ROOT="\[$(tput setaf 15)\]\[$(tput setab 1)\]"
    fi
  }

  __nbe_prompt_py_virtualenv_display() 
  {
    [ -z "$NBE_PROMPT_PY_VIRTUALENV" ] && NBE_PROMPT_PY_VIRTUALENV="on" # sane default
    [ "$NBE_PROMPT_PY_VIRTUALENV" == "off" ] && return # disable display
    [ -n "$VIRTUAL_ENV" ] || return # virtualenvironment not found

    # get virtualenv name
    local venv="$(basename $VIRTUAL_ENV)"
    [ -n "$venv" ] || return

    printf "$COLOR_PY_VIRTUALENV $NBE_PROMPT_PY_VIRTUALENV_SYMBOL $venv $RESET"
  }

  __nbe_prompt_git_display() 
  {
    [ -z "$NBE_PROMPT_GIT" ] && NBE_PROMPT_GIT="on" # sane default
    [ "$NBE_PROMPT_GIT" == "off" ] && return # disable display
    [ -x "$(which git)" ] || return # git not found

    # get current branch name or short SHA1 hash for detached head
    local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
    [ -n "$branch" ] || return  # git branch not found

    local marks

    # branch is modified?
    [ -n "$(git status --porcelain)" ] && marks+=" $NBE_PROMPT_GIT_BRANCH_CHANGED_SYMBOL"

    # how many commits local branch is ahead/behind of remote?
    local stat="$(git rev-list --left-right --boundary @{u}... 2>/dev/null)"
    local aheadN="$(echo $stat | grep -o ">" -c)"
    local behindN="$(echo $stat | grep -o "<" -c)"
    [ "$aheadN" -gt 0 ] && marks+=" $NBE_PROMPT_GIT_NEED_PUSH_SYMBOL$aheadN"
    [ "$behindN" -gt 0 ] && marks+=" $NBE_PROMPT_GIT_NEED_PULL_SYMBOL$behindN"

    printf "$COLOR_GIT $NBE_PROMPT_GIT_BRANCH_SYMBOL$branch$marks $RESET"
  }

  __nbe_prompt_user_display() 
  {
    [ -z "$NBE_PROMPT_USER" ] && NBE_PROMPT_USER="on" # sane default
    [ "$NBE_PROMPT_USER" == "off" ] && return # disable display
    [ -n "$SUDO_USER" ] && COLOR_USER="$COLOR_SUDO"
    [ "$NBE_PROMPT_USER" == "on" ] && printf "$COLOR_USER \\\u $RESET"
  }

  __nbe_prompt_host_display() 
  {
    [ -z "$NBE_PROMPT_HOST" ] && NBE_PROMPT_HOST="auto" # sane default
    [ "$NBE_PROMPT_HOST" == "off" ] && return # disable display
    [ "$NBE_PROMPT_HOST" == "auto" ] && [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && NBE_PROMPT_HOST=on
    [ "$NBE_PROMPT_HOST" == "on" ] && printf "$COLOR_SSH@\\h $RESET"
  }

  __nbe_prompt_path_parted() 
  {
    local dir_split_count=4
    local dir_parted="$PWD"
    local dir_array=""

    IFS='/' read -a dir_array <<< "$PWD"
    if [ ${#dir_array[@]} -gt $dir_split_count ]; 
    then
      local dir_parted="/${dir_array[1]}/.../${dir_array[${#dir_array[@]}-2]}/${dir_array[${#dir_array[@]}-1]}"
    fi

    printf "$dir_parted"
  }

  __nbe_prompt_path_short() 
  {
    [ -z "$NBE_PROMPT_PATH_SHORT_LENGTH" ] && NBE_PROMPT_PATH_SHORT_LENGTH=20 # sane default

    local short_path=$PWD
    (( ${#PWD} > $NBE_PROMPT_PATH_SHORT_LENGTH )) && short_path="..${PWD: -$NBE_PROMPT_PATH_SHORT_LENGTH}"

    printf "$short_path"
  }

  __nbe_prompt_path_short_length() 
  {
    [ -z "$NBE_PROMPT_PATH_SHORT_LENGTH" ] && NBE_PROMPT_PATH_SHORT_LENGTH=20 # sane default

    [ -n $2 ] && local length="$2" # add/subtract by $2 when provided
    [ -z "$length" ] && local length="1" # add/subtract by 1 by default
    [ "$1" == "subtract" ] && ((NBE_PROMPT_PATH_SHORT_LENGTH-=$length))
    [ "$1" == "add" ] && ((NBE_PROMPT_PATH_SHORT_LENGTH+=$length))

    return 0
  }

  __nbe_prompt_path_mini() 
  {
    local current_path="${PWD/$HOME/\~}"

    IFS='/' read -a dir_array <<< "$current_path"

    local path=""
    local dir_len=$((${#dir_array[@]}-1))

    for dir in ${dir_array[@]:0:$dir_len}; 
    do
      [[ $dir == '~' ]] && path="${dir:0:1}" || path="$path/${dir:0:1}"
    done
    path="$path/${dir_array[$dir_len]}"

    printf "$path"
  }

  __nbe_prompt_path_display() 
  {
    [ -z "$NBE_PROMPT_PATH" ] && NBE_PROMPT_PATH="working" # sane default
    [ "$NBE_PROMPT_PATH" == "off" ] && return # disable display
    [ "$PWD" == "$HOME" ] && NBE_PROMPT_PATH="home" #display ~ for home

    local dir_display=""
    case "$NBE_PROMPT_PATH" in
         home) dir_display="~" ;;
         full) dir_display="\\w" ;;
      working) dir_display="\\W" ;;
        short) dir_display="$(__nbe_prompt_path_short)" ;;
       parted) dir_display="$(__nbe_prompt_path_parted)" ;;
         mini) dir_display="$(__nbe_prompt_path_mini)" ;;
    esac

    printf "$COLOR_DIR $dir_display $RESET"
  }

  __nbe_prompt_jobs_display() 
  {
    [ -z "$NBE_PROMPT_JOBS" ] && NBE_PROMPT_JOBS="on" # sane default
    [ "$NBE_PROMPT_JOBS" == "off" ] && return # disable display
    [ $(jobs | wc -l) -ne "0" ] && printf "$COLOR_JOBS \\j $RESET"
  }

  __nbe_prompt_symbol_display() 
  {
    [ -z "$NBE_PROMPT_SYMBOL" ] && NBE_PROMPT_SYMBOL="on" # sane default
    [ "$NBE_PROMPT_SYMBOL" == "off" ] && return # disable display

    # different color for root and regular user
    local symbol_bg=$COLOR_SYMBOL_USER
    [ $EUID -eq 0 ] && symbol_bg=$COLOR_SYMBOL_ROOT

    printf "$symbol_bg \\$ $RESET"
  }

  __nbe_prompt_rc_display() 
  {
    [ -z "$NBE_PROMPT_RC" ] && NBE_PROMPT_RC="on" # sane default
    [ "$NBE_PROMPT_RC" == "off" ] && return # disable display
    [ $1 -ne 0 ] && printf "$COLOR_RC $1 $RESET"
  }

  __nbe_prompt_ps1() 
  {
    # keep this at top!!!
    # capture latest return code
    local RETURN_CODE=$?

    case "$1" in
      off)    PS1='\$ ' ;;
      system) PS1=$NBE_PROMPT_SYSTEM_PS1 ;;
      on)
        # check for supported colors
        __nbe_prompt_colors

        # set prompt
        PS1=""
        PS1+="$(__nbe_prompt_py_virtualenv_display)"
        PS1+="$(__nbe_prompt_user_display)"
        PS1+="$(__nbe_prompt_host_display)"
        PS1+="$(__nbe_prompt_path_display)"
        PS1+="$(__nbe_prompt_git_display)"
        PS1+="$(__nbe_prompt_jobs_display)"
        PS1+="$(__nbe_prompt_symbol_display)"
        PS1+="$(__nbe_prompt_rc_display ${RETURN_CODE})"
        PS1+=" "
        ;;
    esac
  }

  PROMPT_COMMAND="__nbe_prompt_ps1 on"
}

# save system PS1
[[ -z "$NBE_PROMPT_SYSTEM_PS1" ]] && NBE_PROMPT_SYSTEM_PS1=$PS1

# start NBE prompt
__nbe_prompt
unset __nbe_prompt

# load saved configuration
NBE_PROMPT_CONFIG="${NBE_PATH}/.nbe_prompt_config"
[[ -e "$NBE_PROMPT_CONFIG" ]] && __nbe_prompt_config load

# enable auto completion
complete -F __nbe_prompt_complete nbeprompt
