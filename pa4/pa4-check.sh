#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa4
NUMTESTS=6

if [ ! -e backup ]; then
   mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

for NUM in $(seq 1 $NUMTESTS); do
   curl $SRCDIR/infile$NUM.txt > infile$NUM.txt
   curl $SRCDIR/model-outfile$NUM.txt > model-outfile$NUM.txt
   rm -f outfile$NUM.txt
done

curl $SRCDIR/ListTest.c > ListTest.c
curl $SRCDIR/GraphTest.c > ModelGraphTest.c

echo ""
echo ""

make

if [ ! -e FindPath ] || [ ! -x FindPath ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Executable!!!"
   echo ""
   rm -f *.o FindPath
   gcc -c -std=c99 -Wall FindPath.c List.c
   gcc -o FindPath FindPath.o List.o
fi

echo ""
echo ""

pathtestspassed=$(expr 0)
echo "FindPath tests: If nothing between '=' signs, then test is passed:"
for NUM in $(seq 1 $NUMTESTS); do
   echo "FindPath Test $NUM:"
   echo "=========="
   timeout 5 FindPath infile$NUM.txt outfile$NUM.txt &> garbage >> garbage #all stdout / stderr printing thrown away
   diff -bBwu outfile$NUM.txt model-outfile$NUM.txt > diff$NUM.txt &>> diff$NUM.txt
   cat diff$NUM.txt
   echo "=========="
   if [ -e diff$NUM.txt ] && [[ ! -s diff$NUM.txt ]]; then # increment number of tests passed counter
     let pathtestspassed+=1
   fi
done

echo ""
echo ""

let pathtestspoints=2*pathtestspassed
if [ "$pathtestspoints" -gt "10" ]; then # max 10 points
  let pathtestspoints=$(expr 10)
fi
echo "Passed $pathtestspassed FindPath tests for a total of $pathtestspoints / 10 points"

echo ""
echo ""

make clean

if [ -e FindPath ] || [ -e *.o ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
fi

echo ""


echo "Press Enter To Continue with ListTest Results (type v for verbose mode)"
read garbage

gcc -c -std=c99 -Wall ListTest.c List.c
gcc -o ListTest ListTest.o List.o

if [ "$garbage" = "v" ]; then
   timeout 5 ./ListTest -v > ListTest-out.txt
else
   timeout 5 ./ListTest > ListTest-out.txt
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



rm -f *.o ListTest ModelGraphTest FindPath garbage

