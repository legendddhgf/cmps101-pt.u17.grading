#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa2
NUMTESTS=3

if [ ! -e backup ]; then
   mkdir backup
fi


cp *.c *.h Makefile backup   # copy all files of importance into backup

for NUM in $(seq 1 $NUMTESTS); do
   curl $SRCDIR/infile$NUM.txt > infile$NUM.txt
   curl $SRCDIR/model-outfile$NUM.txt > model-outfile$NUM.txt
done

curl $SRCDIR/ListTest.c > ListTest.c

echo ""
echo ""

make

if [ ! -e Lex ] || [ ! -x Lex ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Executable!!!"
   echo ""
   rm -f *.o Lex
   gcc -c -std=c99 -Wall Lex.c List.c
   gcc -o Lex Lex.o List.o
fi

echo ""
echo ""
echo "Lex tests: If nothing between '=' signs, then test is passed:"
for NUM in $(seq 1 $NUMTESTS); do
   echo "Lex Test $NUM:"
   echo "=========="
   timeout 2 valgrind Lex infile$NUM.txt outfile$NUM.txt &> valgrind-out$NUM.txt
   diff -bBwu outfile$NUM.txt model-outfile$NUM.txt > diff$NUM.txt
   cat diff$NUM.txt
   echo "=========="
done

echo ""
echo ""
echo "Press Enter To Continue with Valgrind Results for Lex"
read garbage

for NUM in $(seq 1 $NUMTESTS); do
   echo "Lex Valgrind Test $NUM:"
   echo "=========="
   cat valgrind-out$NUM.txt
   echo "=========="
done

make clean

echo ""
echo ""

if [ -e Lex ] || [ -e *.o ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""


echo "Press Enter To Continue with ListTest Results (type v for verbose mode)"
read garbage

echo ""
echo ""

gcc -c -std=c99 -Wall ListTest.c List.c
gcc -o ListTest ListTest.o List.o

if [ "$garbage" = "v" ]; then
   timeout 2 valgrind ./ListTest -v > ListTest-out.txt
else
   timeout 2 valgrind ./ListTest > ListTest-out.txt
fi

cat ListTest-out.txt

rm -f *.o ListTest Lex

