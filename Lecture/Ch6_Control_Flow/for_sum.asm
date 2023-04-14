#  1 int sum(int *A, int length) {
#  2     int ret = 0;
#  3 
#  4     for(int i = 0; i < length; i++) {
#  5         ret += A[i];
#  6     }
#  7 
#  8     return ret;
#  9 }


        .file   "for_sum.c"             # 
        .text                           # 
        .align  2                       # 
        .globl  sum                     # 
sum:                                    # 
        ble     a1,zero,.L4             # 
        mv      a5,a0                   # 
        addiw   a4,a1,-1                # 
        slli    a4,a4,32                # 
        srli    a4,a4,32                # 
        slli    a4,a4,2                 # 
        addi    a0,a0,4                 # 
        add     a4,a4,a0                # 
        li      a0,0                    # 
.L3:                                    # 
        lw      a3,0(a5)                # 
        addw    a0,a3,a0                # 
        addi    a5,a5,4                 # 
        bne     a5,a4,.L3               # 
        ret                             # 
.L4:                                    # 
        li      a0,0                    # 
        ret                             # 
