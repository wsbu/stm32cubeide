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

case "$0" in
  *org.eclipse.cdt.core.gcc)
    exec $CC "$@"
    ;;
  *org.eclipse.cdt.core.g++)
    exec $CXX "$@"
    ;;
  *)
    echo "Error: Command not supported" 1>&2
    exit 1
esac
