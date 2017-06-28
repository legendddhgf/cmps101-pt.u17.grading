#!/bin/bash

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa1
NUMTESTS=1
for NUM in $(seq 1 $NUMTESTS); do
   curl $SRCDIR/infile$NUM.txt > infile$NUM.txt
done

make

if [ ! -e Lex ] || [ ! -x Lex ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Executable!!!"
   echo ""
   rm -f *.class
   javac -Xlint Lex.java List.java
   echo "Main-class: Lex" > Manifest
   jar cvfm Lex Manifest *.class
   rm Manifest
   chmod +x Lex
fi


echo "If nothing between '=' signs, then test is passed:"
for NUM in $(seq 1 $NUMTESTS); do
   echo "Test 2.$NUM:"
   echo "=========="
   Lex infile$NUM.txt outfile$NUM.txt
   diff -bBwu outfile$NUM.txt model2-outfile$NUM.txt > diff$NUM.txt
   cat diff1.txt
   echo "=========="
done

make clean

echo ""

if [ -e Lex ] || [ -e *.class ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""


