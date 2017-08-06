# ----------------------------------------------------------------------------
#  BASH: Functions - Date
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Date Helper" ${BASH_SOURCE}

function now()
{
    echo $(date +%Y%m%d%H%M%S)
}

function hour()
{
    echo $(date +"%H")
}

function year()
{
    echo $(date +"%Y")
}

function timestamp()
{
    echo $(date +%Y-%m-%d_%H:%M:%S)
}

# Convert a unix timestamp to a date string
function unix2date() 
{
    if [[ -n "$1" ]] ; then
        echo "$1" | awk '{print strftime("%c", $1)}'
        return
    fi
    date
}

# Convert a date string to a unix timestamp
function date2unix() 
{
    if [[ -n "$1" ]] ; then
        date --date "$*" +%s
        return
    fi
    date +%s
}

# gets the current number of millis since the epoch.
# THIS DOESN'T WORK on normal mac. If it fails, check that gnubin is on the PATH
function current_time_millis() 
{
    echo $(($(date +%s%N)/1000000))
}

# converts milliseconds to a human-readable string
function convert_time_string() 
{
  local total_millis="$1"

  if [[ "${total_millis}" == "" ]]; 
  then
    echo "Usage: convert_time_string <millis>"
    return 1
  fi

  ((total_secs=total_millis/1000))
  ((ms=total_millis%1000))
  ((s=total_secs%60))
  ((m=(total_secs%3600)/60))
  ((h=total_secs/3600))

  local time_string=""
  if   ((h>0)); then time_string="${h}h${m}m${s}s"
  elif ((m>0)); then time_string="${m}m${s}s"
  elif ((s>3)); then time_string="${s}s"
  elif ((s>0)); then time_string="${s}.$(printf "%0*d" 3 $ms | sed -e 's/[0]*$//g')s"
  else               time_string="${ms}ms"
  fi

  echo -n "${time_string}"

  # how do you do local vars on arithmetic?
  unset ms
  unset s
  unset m
  unset h
  unset total_secs
}