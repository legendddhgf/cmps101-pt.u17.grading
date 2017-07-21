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

  static int Empty_length;
  static int Append_length;
  static int Prepend_length;
  static int InsertAfter_length;
  static int InsertBefore_length;
  static int DeleteFront_length;
  static int DeleteBack_length;
  static int Delete_length;

  static int EmptyList_index;
  static int MoveFront_index;
  static int MoveBack_index;
  static int MoveNext_index;
  static int MovePrev_index;
  static int Append_index;
  static int Prepend_index;
  static int InsertAfter_index;
  static int InsertBefore_index;
  static int DeleteFront_index;
  static int DeleteBack_index;
  static int Delete_index;

  static int Append_equals;
  static int Prepend_equals;
  static int InsertAfter_equals;
  static int InsertBefore_equals;
  static int DeleteFront_equals;
  static int DeleteBack_equals;
  static int Delete_equals;

  static int Empty_clear;
  static int NonEmpty_clear;

  static int Set_get;
  static int Set_front;
  static int NonEmpty_front;
  static int Set_back;
  static int NonEmpty_back;

  static int Empty_toString;
  static int NonEmpty_toString;


  static String testName(int test) {
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
    NonEmpty_toString = testCount++;

    // set for bits where tests are passed based off above bitmasks
    BitSet testsPassed = new BitSet(testCount); // all tests are 0 (failed) by default

    List A;
    List B;

    int i = 0;
    for (i = 0; i < testCount; i++) {
      try {
        if (i == NonEmpty_toString) {
          A = new List();
          A.append(1);
          A.prepend(5);
          A.deleteBack();
          A.append(7);
          A.append(1);
          if (!A.toString().equals("5 7 1")) continue;
          A = new List();
          A.append(1.0);
          A.prepend(5.0);
          A.deleteBack();
          A.append(7.5);
          A.append(1.43);
          if (!A.toString().equals("5.0 7.5 1.43")) continue;
          A = new List();
          ObjectTestClass obj1 = new ObjectTestClass(1, 4.5, "hello");
          A.append(obj1);
          ObjectTestClass obj2 = new ObjectTestClass(5, 3.14, "how");
          A.prepend(obj2);
          A.deleteBack();
          ObjectTestClass obj3 = new ObjectTestClass(7, 75.5, "are");
          A.append(obj3);
          ObjectTestClass obj4 = new ObjectTestClass(1, 1.43, "you");
          A.append(obj4);
          if (A.toString().equals("5,3.14,how 7,75.5,are 1,1.43,you")) testsPassed.set(i);
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
    }

    System.out.printf("\nPassed %d tests out of %d possible\n", testsPassed.cardinality(), testCount);

    final int maxScore = 60;

    final int totalPoints = (maxScore - testCount) + testsPassed.cardinality();

    System.out.printf("\nThis gives you a score of %d out of %d for this component of the assignment\n\n", totalPoints, maxScore);
  }
}

