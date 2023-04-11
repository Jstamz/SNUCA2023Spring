#  1 long foo(long a, unsigned long b, char *cp)
#  2 {
#  3   char c = *cp;
#  4   long sum=0;
#  5   long n = a > b ? a-b : b-a;
#  6 
#  7   do {
#  8     sum += n + c;
#  9     n--;
# 10   } while (n > 0);
# 11 
# 12   return sum;
# 13 }


        .file   "example.c"
        .text
        .align  2
        .globl  foo
foo:                            # a0 = a, a1 = b, a2 = cp
        lbu     a5,0(a2)        # a5 = load byte at *c        (=c)
        sub     a4,a1,a0        # a4 = b-a                    (=n, ? false, line 5)
        bleu    a0,a1,.L3       # a < b ? goto .L3
        sub     a4,a0,a1        # a4 = a-b                    (=n, ? true, line 5)
.L3:
        add     a5,a5,a4        # a5 = c + n
        li      a0,0            # a0 = 0                      (=sum, line 4)
.L4:
        add     a0,a0,a5        # a0 += a5 (=c+n)             (line 8)
        addi    a4,a4,-1        # a4--                        (=n--, line 9)
        addi    a5,a5,-1        # a5--                        (=(c+n)--)
        bgt     a4,zero,.L4     # a4(=n) > 0 ? goto .L4
        ret                     # return a0(=sum)
