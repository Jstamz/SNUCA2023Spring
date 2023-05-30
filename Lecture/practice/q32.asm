#  1 unsigned int q32(int *a, int idx, long N){
#  2     if(N > 1000) {
#  3         idx = 1000 - idx;
#  4     }
#  5 
#  6     return a[idx];
#  7 }


        .file   "q32.c"                 # 
        .text                           # 
        .align  2                       # 
        .globl  q32                     # 
q32:                                    # 
        li      a5,1000                 # 
        ble     a2,a5,.L2               # 
        subw    a1,a5,a1                # 
.L2:                                    # 
        slli    a1,a1,2                 # 
        add     a0,a0,a1                # 
        lw      a0,0(a0)                # 
        ret                             # 
