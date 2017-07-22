import java.util.BitSet;

class ObjectTestClass {
  int i;
  double d;
  String str;

  ObjectTestClass(int i, double d, String str) {
    this.i = i;
    this.d = d;
    this.str = str;
  }

  public String toString() {
    return i + "," + d + "," + str;
  }
}

class MatrixTest {

  static int Empty_getSize;
  static int NonEmpty_getSize;

  static int Empty_getNNZ;
  static int makeZero_getNNZ;
  static int changeEntry_getNNZ;
  static int copy_getNNZ;
  static int transpose_getNNZ;
  static int add_getNNZ;
  static int sub_getNNZ;
  static int scalarMult_getNNZ;
  static int mult_getNNZ;

  static int Empty_equals;
  static int NonEmpty_equals;

  static int Empty_toString;
  static int NonEmpty_toString;

  static String testName(int test) {

    if (test == Empty_getSize) return "Empty_getSize";
    if (test == NonEmpty_getSize) return "NonEmpty_getSize";

    if (test == Empty_getNNZ) return "Empty_getNNZ";
    if (test == makeZero_getNNZ) return "makeZero_getNNZ";
    if (test == changeEntry_getNNZ) return "changeEntry_getNNZ";
    if (test == copy_getNNZ) return "copy_getNNZ";
    if (test == transpose_getNNZ) return "transpose_getNNZ";
    if (test == add_getNNZ) return "add_getNNZ";
    if (test == sub_getNNZ) return "sub_getNNZ";
    if (test == scalarMult_getNNZ) return "scalarMult_getNNZ";
    if (test == mult_getNNZ) return "mult_getNNZ";

    if (test == Empty_equals) return "Empty_equals";
    if (test == NonEmpty_equals) return "NonEmpty_equals";

    if (test == Empty_toString) return "Empty_toString";
    if (test == NonEmpty_toString) return "NonEmpty_toString";

    return "";
  }

  public static void main(String args[]) {

    if (args.length > 1 || (args.length == 1 && !args[0].equals("-v"))) {
      System.err.println("Usage: ./MatrixTest [-v]");
      System.exit(1);
    }
    boolean verbose = false;
    if (args.length == 1) verbose = true;

    int testCount = 0;
    // form is TESTCASE_FUNCTION
    Empty_getSize = testCount++;
    NonEmpty_getSize = testCount++;

    Empty_getNNZ = testCount++;
    makeZero_getNNZ = testCount++;
    changeEntry_getNNZ = testCount++;
    copy_getNNZ = testCount++;
    transpose_getNNZ = testCount++;
    add_getNNZ = testCount++;
    sub_getNNZ = testCount++;
    scalarMult_getNNZ = testCount++;
    mult_getNNZ = testCount++;

    Empty_equals = testCount++;
    NonEmpty_equals = testCount++;

    Empty_toString = testCount++;
    NonEmpty_toString = testCount++;

    // set for bits where tests are passed based off above bitmasks
    BitSet testsPassed = new BitSet(testCount); // all tests are 0 (failed) by default

    int i = 0;

    Matrix A;
    Matrix B;
    Matrix C;
    Matrix D;

    for (i = 0; i < testCount; i++) {
      try {
        if (i == Empty_getSize) {
          A = new Matrix(3);
          if (A.getSize() == 3) testsPassed.set(i);
        } else if (i == NonEmpty_getSize) {
          A = new Matrix(3);
          A.changeEntry(1, 1, 4);
          A.changeEntry(1, 2, 2);
          A.changeEntry(1, 3, 0);
          A.changeEntry(2, 1, 2);
          A.changeEntry(3, 1, 0);
          A.changeEntry(2, 2, 2);
          A.changeEntry(3, 3, 0);
          if (A.getSize() == 3) testsPassed.set(i);
        } else if (i == Empty_getNNZ) {
          A = new Matrix(3);
          if (A.getNNZ() == 0) testsPassed.set(i);
        } else if (i == makeZero_getNNZ) {
          A = new Matrix(3);
          A.changeEntry(1, 1, 4);
          A.changeEntry(1, 2, 2);
          A.changeEntry(1, 3, 0);
          A.changeEntry(2, 1, 2);
          A.changeEntry(3, 1, 0);
          A.changeEntry(2, 2, 2);
          A.changeEntry(3, 3, 0);
          A.makeZero();
          if (A.getNNZ() == 0) testsPassed.set(i);
        } else if (i == changeEntry_getNNZ) {
          A = new Matrix(10);
          A.changeEntry(1, 1, 4);
          A.changeEntry(1, 2, 2);
          A.changeEntry(1, 3, 5);
          A.changeEntry(2, 1, 2);
          A.changeEntry(3, 1, 5);
          A.changeEntry(2, 2, 2);
          A.changeEntry(3, 3, 5);
          if (A.getNNZ() != 7) continue; //part 1 of this test
          A.changeEntry(1, 3, 0);
          A.changeEntry(3, 1, 0);
          A.changeEntry(3, 3, 0);
          if (A.getNNZ() != 4) continue; //part 2 of this test
          A.changeEntry(7, 6, 42);
          A.changeEntry(10, 1, 24);
          if (A.getNNZ() != 6) continue; //part 3 of this test
          A.changeEntry(7, 6, 0);
          if (A.getNNZ() != 5) continue; //part 4 of this test
          A.makeZero();
          A.changeEntry(5, 5, 5);
          if (A.getNNZ() == 1) testsPassed.set(i);
        } else if (i == copy_getNNZ) {
          A = new Matrix(10);
          B = A.copy();
          if (B.getNNZ() != 0) continue; //part 1 of this test
          A.changeEntry(1, 1, 1);
          B = A.copy();
          if (B.getNNZ() == 1) testsPassed.set(i);
        } else if (i == transpose_getNNZ) {
          A = new Matrix(3);
          B = A.transpose();
          if (B.getNNZ() != 0) continue; //part 1 of this test
          A.changeEntry(1, 1, 4);
          A.changeEntry(1, 2, 2);
          A.changeEntry(1, 3, 0);
          A.changeEntry(2, 1, 2);
          A.changeEntry(3, 1, 0);
          A.changeEntry(2, 2, 2);
          A.changeEntry(3, 3, 0);
          B = A.transpose();
          if (B.getNNZ() == 4) testsPassed.set(i);
        } else if (i == add_getNNZ) {
        } else if (i == sub_getNNZ) {
        } else if (i == scalarMult_getNNZ) {
        } else if (i == mult_getNNZ) {

        } else if (i == Empty_equals) {
        } else if (i == NonEmpty_equals) {

        } else if (i == Empty_toString) {
        } else if (i == NonEmpty_toString) {

        }
      }catch (Exception e) {
        if (verbose) {
          System.out.println("\nUnfortunately your program crashed on test " + testName(i) + " With an exception of:\n");
          e.printStackTrace();
          System.out.println();
        }
      }
    }

    if (verbose) {
      System.out.println("\nList of tests passed/failed:\n");
      for (i = 0; i < testCount; i++) {
        System.out.printf("%s %s\n", testName(i), testsPassed.get(i) ? "PASSED" : "FAILED");
      }
      System.out.println();
      System.out.printf("\nPassed %d tests out of %d possible\n", testsPassed.cardinality(), testCount);
    }

    final int maxScore = 60;

    final int totalPoints = (maxScore - testCount * 3) + testsPassed.cardinality() * 3; // three points per test

    System.out.printf("\nThis gives you a score of %d out of %d for MatrixTest\n\n", totalPoints, maxScore);
  }
}

