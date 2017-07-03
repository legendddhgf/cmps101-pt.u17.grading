#!/bin/bash
# cmps101-pt.u17 grading
# usage: pa1.sh
# (run within your pa1 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa1
EXE="pa1-check.sh"
SCRIPT=$(mktemp)

curl $SRCDIR/$EXE > $SCRIPT
chmod +x $SCRIPT
$SCRIPT
rm -f $SCRIPT
