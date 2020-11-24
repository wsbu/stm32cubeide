#!/bin/bash

echo "Wrapper for $0"

# Remove wrappers from $PATH
export PATH=`echo $PATH | sed -e 's/^[^:]*://'`

# Source the OpenSTLinux environment
if [ -d $SDKPATH ]; then
  source $SDKPATH/environment-setup-*
else
  echo "Error: SDKPATH does not exist: $SDKPATH" 1>&2
  exit 1
fi

# Run the real application
command=`basename $0`

# Translate the command to the symbol from SDK
set -x
case "$command" in
  *-gcc|gcc)
    exec $CC "$@"
    ;;
  *-g++|g++)
    exec $CXX "$@"
    ;;
  *-ar|ar)
    exec $AR "$@"
    ;;
  *-as|as)
    exec $AS "$@"
    ;;
  *)
    exec $command "$@"
    ;;
esac
