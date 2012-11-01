#
# common shell functions for digirest commands
#


# __Colorizing functions__


# Unset `RERUN_COLOR` to disable.
txtrst () { tput sgr0 ; }
bold() { echo -e "\033[1m$*\033[0m" ; txtrst ; }
dim() { tput dim ; echo " $*" ; txtrst ; }
[ -n "$RERUN_COLOR" ] && {
    ul="\033[4m" ; _ul="\033[0m" ; # underline
    gray="\033[38;5;238m" ; _gray="\033[0m" ; # gray
    red="\033[31m" ; _red="\033[0m" ; # red
    bold="\033[1m$*\033[0m" ; _bold="\033[0m" ; # bold
}

#
# error handling functions -
#

# Print the message and exit.
# Use text effects if `RERUN_COLOR` environment variable set.
rerun_die() {
    if [[ "$RERUN_COLOR" == "true" ]]
    then echo >&2 -e ${red}"ERROR: $*"${_red} 
    else echo >&2 "ERROR: $*" 
    fi
    exit 1
}

_init_log() {
  local timestamp=`date +%Y%m%d`
  logs="./logs"
  log_filename="${1}"
  if [ ! -d ${logs} ]; then
    mkdir $logs
  fi
  find $logs -name ${log_filename} -type f -size +512k | while read logfile
  do
    echo $logfile
    local newlogfile=$logfile.$timestamp
    cp $logfile $newlogfile
    cat /dev/null > $logfile
    gzip -f -9 $newlogfile
  done
  find $logs -name "${log_filename}*.gz" -type f -mtime 30 |xargs rm -f
}

_log(){
  local date_stamp=`date`
  local text="${1} ${2}"
  echo ${date_stamp}: ${text} >> $logs/$log_filename;
}

_debug() {
  echo -e 1>&2 "\033[34m-->" $@ "\033[0m"
}

_info() {
  echo -e 1>&2 "\033[32m-->" $@ "\033[0m"
}

_error() {
  echo -e 1>&2 "\033[31m-->" $@ "\033[0m"
}

_happy() {
  echo -e 1>&2 "\033[36m-->" $@ "\033[0m"
}

_fatal() {
  echo -e 1>&2 "\033[31m-->" $@ "\033[0m"
  exit 2
}

_happyQuit() {
  echo -e 1>&2 "\033[36m-->" $@ "\033[0m"
  exit 0
}

