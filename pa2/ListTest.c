#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define FIRST_TEST Empty_length

enum Test_e {
   Empty_length = 0,
   Append_length,
   Prepend_length,
   InsertAfter_length,
   InsertBefore_length,
   DeleteFront_length,
   DeleteBack_length,
   Delete_length,

   EmptyList_index,
   MoveFront_index,
   MoveBack_index,
   MoveNext_index,
   MovePrev_index,
   Append_index,
   Prepend_index,
   InsertAfter_index,
   InsertBefore_index,
   DeleteFront_index,
   DeleteBack_index,
   Delete_index,

   Append_equals,
   Prepend_equals,
   InsertAfter_equals,
   InsertBefore_equals,
   DeleteFront_equals,
   DeleteBack_equals,
   Delete_equals,

   Empty_clear,
   NonEmpty_clear,

   Set_get,
   Set_front,
   NonEmpty_front,
   Set_back,
   NonEmpty_back,

   Empty_copy,
   NonEmpty_copy,

   Empty_toString,
   NonEmpty_toString,
}


char *testName(int test) {
   if (test == Empty_length) return "Empty_length";
   if (test == Append_length) return "Append_length";
   if (test == Prepend_length) return "Prepend_length";
   if (test == InsertAfter_length) return "InsertAfter_length";
   if (test == InsertBefore_length) return "InsertBefore_length";
   if (test == DeleteFront_length) return "DeleteFront_length";
   if (test == DeleteBack_length) return "DeleteBack_length";
   if (test == Delete_length) return "Delete_length";

   if (test == EmptyList_index) return "EmptyList_index";
   if (test == MoveFront_index) return "MoveFront_index";
   if (test == MoveBack_index) return "MoveBack_index";
   if (test == MoveNext_index) return "MoveNext_index";
   if (test == MovePrev_index) return "MovePrev_index";
   if (test == Append_index) return "Append_index";
   if (test == Prepend_index) return "Prepend_index";
   if (test == InsertAfter_index) return "InsertAfter_index";
   if (test == InsertBefore_index) return "InsertBefore_index";
   if (test == DeleteFront_index) return "DeleteFront_index";
   if (test == DeleteBack_index) return "DeleteBack_index";
   if (test == Delete_index) return "Delete_index";

   if (test == Append_equals) return "Append_equals";
   if (test == Prepend_equals) return "Prepend_equals";
   if (test == InsertAfter_equals) return "InsertAfter_equals";
   if (test == InsertBefore_equals) return "InsertBefore_equals";
   if (test == DeleteFront_equals) return "DeleteFront_equals";
   if (test == DeleteBack_equals) return "DeleteBack_equals";
   if (test == Delete_equals) return "Delete_equals";

   if (test == Empty_clear) return "Empty_clear";
   if (test == NonEmpty_clear) return "NonEmpty_clear";

   if (test == Set_get) return "Set_get";
   if (test == Set_front) return "Set_front";
   if (test == NonEmpty_front) return "NonEmpty_front";
   if (test == Set_back) return "Set_back";
   if (test == NonEmpty_back) return "NonEmpty_back";

   if (test == Empty_copy) return "Empty_copy";
   if (test == NonEmpty_copy) return "NonEmpty_copy";

   if (test == Empty_toString) return "Empty_toString";
   if (test == NonEmpty_toString) return "NonEmpty_toString";

   return "";
}



int main (int argc, char **argv) {











   return 0;
}
