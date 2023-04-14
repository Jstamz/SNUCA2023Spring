#  1 void strcpy(char x[], char y[]) {
#  2     int i = 0;
#  3 
#  4     while ((x[i] != '\0') || (y[i] != '\0'))
#  5     {
#  6         x[i] = y[i];
#  7         i++;
#  8     }
#  9 }


        .file   "strcpy.c"              # 
        .text                           # 
        .align  2                       # 
        .globl  strcpy                  # 
strcpy:                                 # 
        j       .L2                     # 
.L3:                                    # 
        lbu     a5,0(a1)                # a5 = y[i]
        sb      a5,0(a4)                # x[i] = a5
        addi    a0,a0,1                 # 
        addi    a1,a1,1                 # actually, i++
.L2:                                    # 
        mv      a4,a0                   # a4 = &x[0]
        lbu     a5,0(a0)                # a5 = x[0]
        bne     a5,zero,.L3             # a5 != 0 goto .L3
        lbu     a5,0(a1)                # a5 = &y[i]
        bne     a5,zero,.L3             # a5 != 0 goto .L3
        ret                             # 
