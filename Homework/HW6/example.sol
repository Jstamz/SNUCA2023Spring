#  1 #include <stdlib.h>
#  2 
#  3 long init(long *a, long from, long to)
#  4 {
#  5   long ninit = 0;
#  6 
#  7   for (long i=from; i<to; i++) {
#  8     a[i] = (unsigned long)random() % 1024;
#  9     ninit++;
# 10   }
# 11 
# 12   return ninit;
# 13 }


        .file   "example.c"
        .text
        .align  2
        .globl  init
init:                                   # function entry point
                                        #   a0: int *a (address to array)
                                        #   a1: int from
                                        #   a2: int to

        bge     a1,a2,.L4               # if (from >= to) goto .L4

                                        # prologue
        addi    sp,sp,-48               #   make room on stack (16-align)
        sd      ra,40(sp)               #   save callee-saved ra
        sd      s0,32(sp)               #   save callee-saved s0
        sd      s1,24(sp)               #   save callee-saved s1
        sd      s2,16(sp)               #   save callee-saved s2
        sd      s3,8(sp)                #   save callee-saved s3

        mv      s3,a1                   # s3 = copy of from
        mv      s2,a2                   # s2 = copy of to
        slli    s0,a1,3                 # s0 = 8*from
        add     s0,a0,s0                # s0 = a + 8*from = &a[from]
        slli    s1,a2,3                 # s1 = 8*to
        add     s1,a0,s1                # s1 = a + 8*to = &a[to] (end)

.L3:                                    # for loop
        call    random                  # call random() (no arguments)
        andi    a0,a0,1023              # a0 = result % 1024 = a0 & 0xfff
        sd      a0,0(s0)                # a[from] = a0 (= random() % 1024)
        addi    s0,s0,8                 # s0 = s0 + 8 = next element in a
        bne     s0,s1,.L3               # loop until s0==s1

        sub     a0,s2,s3                # a0 = nnit = to - from
                                        #   (compiler realizes there is no need
                                        #    to compute this in the loop)

                                        # epilogue
        ld      ra,40(sp)               #   restore ra
        ld      s0,32(sp)               #   restore s0
        ld      s1,24(sp)               #   restore s1
        ld      s2,16(sp)               #   restore s2
        ld      s3,8(sp)                #   restore s3
        addi    sp,sp,48                #   restore sp

        jr      ra                      # return (return value in a0)

.L4:                                    # short-cut exit if from>=to
        li      a0,0                    # a0 = ninit = 0
        ret                             # return (return value in a0)
