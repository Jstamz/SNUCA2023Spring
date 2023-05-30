#  1 #define N 10
#  2 #define M 100
#  3 
#  4 int A[N][M];
#  5 
#  6 int get(int i, int j)
#  7 {
#  8     return A[i][j];
#  9 }
# 10 
# 11 int sum(void)
# 12 {
# 13     int i, j, sum = 0;
# 14 
# 15     for (i=0; i<N; i++) {
# 16         for (j=0; j<M; j++) {
# 17             sum += A[i][j];
# 18         }
# 19     }
# 20     
# 21     return sum;
# 22 } 


        .file   "2darray.c"             # 
        .text                           # 
        .align  2                       # 
        .globl  get                     # 
get:                                    # 
        lui     a5,%hi(A)               # 
        addi    a5,a5,%lo(A)            # a5 = &A;
        li      a4,100                  # a4 = 100(M)
        mul     a0,a0,a4                # i *= 100
        add     a0,a0,a1                # i += j
        slli    a0,a0,2                 # i *= 4
        add     a5,a5,a0                # a5 = &A[j + M * 100]
        lw      a0,0(a5)                # a5 = A[j + M * 100]
        ret                             # return
        .align  2                       # 
        .globl  sum                     # 
sum:                                    # 
        lui     a2,%hi(A)               # 
        addi    a2,a2,%lo(A)            # 
        addi    a3,a2,400               # 
        li      a5,4096                 # 
        addi    a5,a5,304               # 
        add     a2,a2,a5                # 
        li      a0,0                    # 
.L3:                                    # 
        addi    a5,a3,-400              # 
.L4:                                    # 
        lw      a4,0(a5)                # 
        addw    a0,a4,a0                # 
        addi    a5,a5,4                 # 
        bne     a5,a3,.L4               # 
        addi    a3,a3,400               # 
        bne     a3,a2,.L3               # 
        ret                             # 
        .globl  A                       # 
        .bss                            # 
        .align  3                       # 
A:                                      # 
        .zero   4000                    # 
