# Homework 5

This homework will help improve your understanding of RISC-V assembly and C-to-assembly translation. Fork this repository, run `git clone`, compile `p1.c` and `p2.c`, then analyze and annotate the generated assembly. Upload your solutions to [eTL](https://myetl.snu.ac.kr/courses/240373/assignments/191293) by April 12th.


## Solution Example

### Given C Code Example

```c
long foo(long a, unsigned long b, char *cp)
{
  char c = *cp;
  long sum=0;
  long n = a > b ? a-b : b-a;

  do {
    sum += n + c;
    n--;
  } while (n > 0);

  return sum;
}
```

### Annotation Example

```
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
```

## Compilation

You can use the provided `Makefile` with:

```
make all
```

which will create `example.ans`, `p1.ans`, and `p2.ans`. Fill out the annotations for `p1.ans` and `p2.ans` like the given example [above](#annotation-example).

## Troubleshoot

### /opt/riscv/bin/riscv64-unknown-elf-gcc: No such file or directory

You are missing the RISC-V toolchain.

Options.
1. Install the CSAP RISC-V VM  
    This VM includes all tools and programs required for homework assignments and the term project.
    To install the VM on your machine, follow the instructions in the [RISC-V Development Environment guide](https://teaching.csap.snu.ac.kr/computer-architecture/spring-2023/risc-v-vm).

2. Install the RISC-V GNU Compiler Toolchain on your machine  
    If you are using a Debian/Ubuntu-based distribution you can download the RISC-V toolchain from [here](https://github.com/riscv-collab/riscv-gnu-toolchain) and then install it with  
    ```
    sudo apt-get install gcc-riscv64-unknown-elf
    ```
    If you have installed the package and still doesn't work, change the `riscv64-unknown-elf-gcc` path inside `Makefile`. You can find the binary path by  
    ```
    which riscv64-unknown-elf-gcc
    ```
    and replace the `CC` macro inside `Makefile` with the output.

Note that we only provide support for the CSAP RISC-VM. 



