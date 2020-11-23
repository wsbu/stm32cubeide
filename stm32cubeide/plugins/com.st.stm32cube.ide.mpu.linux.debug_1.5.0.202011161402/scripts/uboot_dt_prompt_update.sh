#!/bin/bash
#set -x

# $1: Device Tree name to be added
#     typically  : stm32mp157c-ev1_mx-mx
# $2: .conf file to be modified
#      typically : extlinux.conf

EXITCODE_ALREADY_DEFAULT=1
EXITCODE_ALREADY_CHOICE=2
EXITCODE_ERROR=3
AWK_TOOL=gawk


LOG="/dev/null"
LOG="/tmp/`basename $0`"
> $LOG
echo "Log available in $LOG"

echo2() {
    echo $@
    echo "$@" >> $LOG
}

# Requirement checks
command -v $AWK_TOOL >/dev/null 2>&1 || {
    echo2 "Missing requirement: $AWK_TOOL";
    exit $EXITCODE_ERROR;
}

# Argument check
if [ $# -lt 2 ]; then
    echo2 "Usage: $0 <Device Tree name> <*.conf file to modify>"
    exit $EXITCODE_ERROR
fi

DT_NAME="$1"						# Device Tree name to be added
CONF_FILE="$2"						# .conf file to be modified
CONF_FILE_SAVE="$2.save"					# .conf file saved
GAWK_SCRIPT='
/DEFAULT/ {
   print "DEFAULT " newDTName ; next;
}

{
print $0
}

/KERNEL/ {
   kernel= $1 " " $2
 };

/FDT/ {
   fdt= $1 " /" newDTName ".dtb"
 };

/INITRD/ {
   initrd= $1 " " $2
};

/APPEND/ {
   append= $1 " " $2 " " $3 " " $4 " " $5
 };


END {
    print "LABEL " newDTName;
    print "\t" kernel;
    print "\t" fdt;
    print "\t" initrd;
    print "\t" append;
};
'

# Check if Device Tree is already supported

grep "DEFAULT" "$CONF_FILE" | grep "$DT_NAME"
RET=$?

if [ $RET -eq 0 ]; then
	echo2 "$DT_NAME is already the default Device Tree in $CONF_FILE"
	exit $EXITCODE_ALREADY_DEFAULT
fi

grep "LABEL" "$CONF_FILE" | grep "$DT_NAME"
RET=$?

if [ $RET -eq 0 ]; then
	echo2 "$DT_NAME is already a choice in $CONF_FILE"
	exit $EXITCODE_ALREADY_CHOICE
fi

/bin/cp "$CONF_FILE" "$CONF_FILE.save"

$AWK_TOOL -v newDTName="$DT_NAME" "$GAWK_SCRIPT" "$CONF_FILE_SAVE" > $CONF_FILE

exit 0






