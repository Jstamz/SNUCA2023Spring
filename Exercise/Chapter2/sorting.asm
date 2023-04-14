#  1 void swap(int v[], int idx) {
#  2     int temp = v[idx];
#  3     v[idx] = v[idx+1];
#  4     v[idx+1] = temp;
#  5 }
#  6 
#  7 void sort(int v[], int N) {
#  8     for (int i = 0; i < N; i++)
#  9     {
# 10         for (int j = i - 1; j >= 0; j--)
# 11         {
# 12             if(v[j] > v[j+1]) {
# 13                 swap(v, j);
# 14             }
# 15         }
# 16     }
# 17 }


        .file   "sorting.c"             # 
        .text                           # 
        .align  2                       # 
        .globl  swap                    # 
swap:                                   # 
        slli    a1,a1,2                 # 
        add     a5,a0,a1                # a5 = &a[idx]
        lw      a4,0(a5)                # a4 = a[idx]
        addi    a1,a1,4                 # a1 = a1 + 4(idx++)
        add     a0,a0,a1                # a0 = &a[idx]
        lw      a3,0(a0)                # a3 = a[idx]
        sw      a3,0(a5)                # a3 = a4
        sw      a4,0(a0)                # a4 = a3
        ret                             # 
        .align  2                       # 
        .globl  sort                    # 
sort:                                   # 
                                        # a0 = v[], a1 = N
        ble     a1,zero,.L11            # entry point
        addi    sp,sp,-64               # prologue
        sd      ra,56(sp)               # 
        sd      s0,48(sp)               # 
        sd      s1,40(sp)               # 
        sd      s2,32(sp)               # 
        sd      s3,24(sp)               # 
        sd      s4,16(sp)               # 
        sd      s5,8(sp)                # 
        sd      s6,0(sp)                # 
                                        # prologue end
        mv      s4,a0                   # save a0 in s4
        mv      s5,a0                   # save a0 in s5
        addiw   s6,a1,-1                # s6 = a1 - 1(s6 = N - 1)
        li      s3,0                    # s3 = 0
        li      s2,-1                   # s2 = -1
        j       .L4                     # goto .L4
.L6:                                    # 
        addiw   s1,s1,-1                # s1 = s1 - 1(j--)
        addi    s0,s0,-4                # s0 = s0 - 4(previous address)
        beq     s1,s2,.L5               # if s1 == s2 goto .L5
.L7:                                    # 
        lw      a4,0(s0)                # a4 = k[j]
        lw      a5,4(s0)                # a5 = k[k+1]
        ble     a4,a5,.L6               # skip if statement
        mv      a1,s1                   # a1 = s1(idx)
        mv      a0,s4                   # a0 = k[j]
        call    swap                    # 
        j       .L6                     # goto .L6
.L5:                                    # 
        addiw   s3,s3,1                 # s3 = s3 + 1(i++)
        addi    s5,s5,4                 # s5 = s5 + 4(next address of v)
.L4:                                    # 
        sext.w  s1,s3                   # s1 = extend s3
        beq     s3,s6,.L14              # s3 == N - 1 ? goto .L14(loop end)
        blt     s1,zero,.L5             # s1 < 0 ? goto .L5
        mv      s0,s5                   # s0 = 
        j       .L7                     # goto .L7
.L14:                                   # 
        ld      ra,56(sp)               # epilogue
        ld      s0,48(sp)               # 
        ld      s1,40(sp)               # 
        ld      s2,32(sp)               # 
        ld      s3,24(sp)               # 
        ld      s4,16(sp)               # 
        ld      s5,8(sp)                # 
        ld      s6,0(sp)                # 
                                        # epilogue end
        addi    sp,sp,64                # 
        jr      ra                      # 
.L11:                                   # 
        ret                             # 
