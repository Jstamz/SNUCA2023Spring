#  1 long if_elseif_else(long a, long b, long c) {
#  2     long ret = 0;
#  3     
#  4     if(a > b) a++;
#  5     else if(b > c) b += 2;
#  6     else c += 3;
#  7 
#  8     ret = a + b * c;
#  9 
# 10     return ret;
# 11 }


        .file   "if_elseif_else.c"      # 
        .text                           # 
        .align  2                       # 
        .globl  if_elseif_else          # 
if_elseif_else:                         # 
        ble     a0,a1,.L2               # 
        addi    a0,a0,1                 # 
.L3:                                    # 
        mul     a1,a1,a2                # 
        add     a0,a1,a0                # 
        ret                             # 
.L2:                                    # 
        ble     a1,a2,.L4               # 
        addi    a1,a1,2                 # 
        j       .L3                     # 
.L4:                                    # 
        addi    a2,a2,3                 # 
        j       .L3                     # 
