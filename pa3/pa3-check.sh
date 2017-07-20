#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/legendddhgf/cmps101-pt.u17.grading/master/pa3
NUMTESTS=5

if [ ! -e backup ]; then
   mkdir backup
fi


cp *.java Makefile backup   # copy all files of importance into backup

for NUM in $(seq 1 $NUMTESTS); do
   curl $SRCDIR/infile$NUM.txt > infile$NUM.txt
   curl $SRCDIR/model-outfile$NUM.txt > model-outfile$NUM.txt
done

curl $SRCDIR/ListTest.java > ListTest.java

make

if [ ! -e Sparse ] || [ ! -x Sparse ]; then # exist and executable
   echo ""
   echo "Makefile doesn't correctly create Executable!!!"
   echo ""
   rm -f *.class
   javac -Xlint Sparse.java Matrix.java List.java
   echo "Main-class: Sparse" > Manifest
   jar cvfm Sparse Manifest *.class
   rm Manifest
   chmod +x Sparse
fi

echo ""
echo ""

echo "Sparse tests: If nothing between '=' signs, then test is passed:"
for NUM in $(seq 1 $NUMTESTS); do
   echo "Test $NUM:"
   echo "=========="
   timeout 2 Sparse infile$NUM.txt outfile$NUM.txt &> garbage >> garbage
   diff -bBwu outfile$NUM.txt model-outfile$NUM.txt > diff$NUM.txt
   cat diff$NUM.txt
   echo "=========="
done

echo ""
echo ""

make clean


echo ""
echo ""

if [ -e Sparse ] || [ -e *.class ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
  echo ""
  echo ""
fi


echo "Press Enter To Continue with ListTest Results (type v for verbose mode)"
read garbage

javac ListTest.java List.java

if [ "$garbage" = "v" ]; then
   timeout 2 java ListTest -v > ListTest-out.txt &>> ListTest-out.txt
else
   timeout 2 java ListTest > ListTest-out.txt &>> ListTest-out.txt
fi

cat ListTest-out.txt

rm *.class

