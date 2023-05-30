#  1 int foo(long a, long b);
#  2 
#  3 int bar(long a, long b);
#  4 
#  5 int if_else(long a, long b) {
#  6     int res;
#  7 
#  8     if(a >= b) res = foo(a, b);
#  9     else res = bar(a, b);
# 10 
# 11     return res*2;
# 12 }


        .file   "if_else.c"             # 
        .text                           # 
        .align  2                       # 
        .globl  if_else                 # 
if_else:                                # 
        addi    sp,sp,-16               # 
        sd      ra,8(sp)                # 
        blt     a0,a1,.L2               # 
        call    foo                     # 
.L3:                                    # 
        slliw   a0,a0,1                 # 
        ld      ra,8(sp)                # 
        addi    sp,sp,16                # 
        jr      ra                      # 
.L2:                                    # 
        call    bar                     # 
        j       .L3                     # 
