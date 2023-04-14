#  1 #define WSIZE 8*sizeof(long)
#  2 
#  3 long pconut_for(unsigned long x) {
#  4     long result = 0;
#  5 
#  6     for (int i = 0; i < WSIZE; i++)
#  7     {
#  8         unsigned long mask = 1 << i;
#  9         result += (x & mask) != 0;
# 10     }
# 11 
# 12     return result;
# 13 }


        .file   "for_loop.c"            # 
        .text                           # 
        .align  2                       # 
        .globl  pconut_for              # 
pconut_for:                             # 
        mv      a3,a0                   # 
        li      a4,0                    # 
        li      a0,0                    # 
        li      a1,1                    # 
        li      a2,64                   # 
.L2:                                    # 
        sllw    a5,a1,a4                # 
        and     a5,a5,a3                # 
        snez    a5,a5                   # 
        add     a0,a0,a5                # 
        addiw   a4,a4,1                 # 
        bne     a4,a2,.L2               # 
        ret                             # 
