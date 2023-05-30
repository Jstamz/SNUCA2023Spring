#  1 int fact(int n)
#  2 {
#  3     if (n < 1) return 1;
#  4         else return n * fact(n-1);
#  5 }


        .file   "fact.c"                # 
        .text                           # 
        .align  2                       # 
        .globl  fact                    # 
fact:                                   # 
        bgt     a0,zero,.L8             # a0 > 0 goto .L8
        li      a0,1                    # a0 = 1
        ret                             # return 1
.L8:                                    # 
        addi    sp,sp,-16               # 2 register data ra, n
        sd      ra,8(sp)                # save ra (callee - saved)
        sd      s0,0(sp)                # save n (callee - saved)
        mv      s0,a0                   # mv s0 to a0 (saving n)
        addiw   a0,a0,-1                # a0 = a0 - 1 (set n-1)
        call    fact                    # call fact
        mulw    a0,a0,s0                # multiply n * fact(n - 1)
        ld      ra,8(sp)                # restore return adress
        ld      s0,0(sp)                # restore s0(n)
        addi    sp,sp,16                # restore stack frame
        jr      ra                      # return
