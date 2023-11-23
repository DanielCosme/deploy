#!/usr/bin/env bash
set -eo pipefail

# Set the root directory
DIR=`dirname "$(readlink -f "$0")"`

# Include functions and default settings
source $DIR/src/functions.sh
source $DIR/settings.sh

USAGE="
Usage:

  $0
  $0 -u UNIT -s STEP

Options:

  -u UNIT    run only a given unit
  -s STEP    run only a given step
  -v         run in the verbose mode"

#
# Process script arguments
#
while getopts ":u:s:vh" opt; do
  case $opt in
    u)
      RUN_UNIT=$OPTARG
      ;;
    s)
      RUN_STEP=$OPTARG
      ;;
    v)
      VERBOSE=true
      ;;
    h)
      echo "$USAGE"
      exit 0
      ;;
    \?)
      echo "$OPTARG is not a valid option."
      echo "$USAGE"
      exit 1
      ;;
  esac
done

# After setting the defaults, run your SSH commands
ssh root@$SERVER -p $PORT $SSH_OPTIONS "dnf update"
