#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa5
NUMTESTS=10

if [ ! -e backup ]; then
   mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

for NUM in $(seq 1 $NUMTESTS); do
   curl $SRCDIR/infile$NUM.txt > infile$NUM.txt
   curl $SRCDIR/model-outfile$NUM.txt > model-outfile$NUM.txt
   rm -f outfile$NUM.txt
done

curl $SRCDIR/ListTest.c > ModelListTest.c
curl $SRCDIR/GraphTest.c > ModelGraphTest.c

echo ""
echo ""

make

if [ ! -e FindComponents ] || [ ! -x FindComponents ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Executable!!!"
   echo ""
   rm -f *.o FindComponents
   gcc -c -std=c99 -Wall FindComponents.c Graph.c List.c
   gcc -o FindComponents FindComponents.o Graph.o List.o
fi

echo ""
echo ""

componenttestspassed=$(expr 0)
echo "FindComponents tests: If nothing between '=' signs, then test is passed:"
for NUM in $(seq 1 $NUMTESTS); do
   echo "FindComponents Test $NUM:"
   echo "=========="
   timeout 5 FindComponents infile$NUM.txt outfile$NUM.txt &> garbage >> garbage #all stdout / stderr printing thrown away
   diff -bBwu outfile$NUM.txt model-outfile$NUM.txt > diff$NUM.txt &>> diff$NUM.txt
   cat diff$NUM.txt
   echo "=========="
   if [ -e diff$NUM.txt ] && [[ ! -s diff$NUM.txt ]]; then # increment number of tests passed counter
     let componenttestspassed+=1
   fi
done

echo ""
echo ""

let componenttestspoints=2*componenttestspassed
if [ "$componenttestspoints" -gt "20" ]; then # max 10 points
  let componenttestspoints=$(expr 20)
fi
echo "Passed $componenttestspassed FindComponents tests for a total of $componenttestspoints / 20 points"

echo ""
echo ""

make clean

if [ -e FindComponents ] || [ -e *.o ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""


echo "Press Enter To Continue with ListTest Results (type v for verbose mode)"
read garbage

gcc -c -std=c99 -Wall ModelListTest.c List.c
gcc -o ModelListTest ModelListTest.o List.o

if [ "$garbage" = "v" ]; then
   timeout 5 ./ModelListTest -v > ListTest-out.txt
else
   timeout 5 ./ModelListTest > ListTest-out.txt
fi

cat ListTest-out.txt

echo ""
echo ""

echo "Press Enter To Continue with GraphTest Results (type v for verbose mode)"
read garbage

gcc -c -std=c99 -Wall ModelGraphTest.c Graph.c List.c
gcc -o ModelGraphTest ModelGraphTest.o Graph.o List.o

if [ "$garbage" = "v" ]; then
   timeout 5 valgrind ./ModelGraphTest -v
else
   timeout 5 valgrind ./ModelGraphTest
fi



rm -f *.o ModelListTest ModelGraphTest FindComponents garbage

