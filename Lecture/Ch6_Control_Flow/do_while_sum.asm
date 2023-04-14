#  1 int sum(int *A, int length) {
#  2     int ret = 0;
#  3     int i = 0;
#  4 
#  5     if(length == 0) return 0;
#  6 
#  7     do {
#  8         ret += A[i];
#  9         i++;
# 10     } while (i < length);
# 11 
# 12     return ret;
# 13 }


        .file   "do_while_sum.c"        # 
        .text                           # 
        .align  2                       # 
        .globl  sum                     # 
sum:                                    # 
        beq     a1,zero,.L4             # 
        mv      a5,a0                   # 
        li      a4,0                    # 
        li      a0,0                    # 
.L3:                                    # 
        lw      a3,0(a5)                # 
        addw    a0,a3,a0                # 
        addiw   a4,a4,1                 # 
        addi    a5,a5,4                 # 
        bgt     a1,a4,.L3               # 
        ret                             # 
.L4:                                    # 
        mv      a0,a1                   # 
        ret                             # 
