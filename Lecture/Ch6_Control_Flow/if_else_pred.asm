#  1 int foo(long a, long b);
#  2 
#  3 int bar(long a, long b);
#  4 
#  5 int if_else(long a, long b) {
#  6     int res;
#  7 
#  8     if(a >= b) res = foo(a, b);
#  9     else res = bar(b, a);
# 10 
# 11     return res*2;
# 12 }


        .file   "if_else.c"             # 
        .text                           # 
        .align  2                       # 
        .globl  if_else                 # 
if_else:                                # 
        addi sp,sp,-16
        sd ra,8(sp)
        