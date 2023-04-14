1)
```asm
add     x5,x6,x7
addi    x5,-5
```

2)
```c
int f = g + h + i
```

3)
```asm
sub     x0,s28,s29
slli    x0,3
add     x10,x10,x0
ld      x0,0(x10)
sd      x0,64(x11)
```

4)
```asm
.Some       # f = x5, g = x6, h =x7, i = x28, j = x29, A = x10, B = x11
    slli    x30,x5,2        # t1 = f * 4
    add     x30,x10,x30     # t1 += &A[0]
                            # t1 = &A[f]
    slli    x31,x6,2        # t2 = g * 4
    add     x31,x11,x31     # t2 += &B[0]
                            # t2 = &B[g]
    lw      x5,0(x30)       # f = A[f]
    addi    x12,x30,4       # t3 = &A[f+1]
    lw      x30,0(x12)      # t1 = A[f+1]
    add     x30,x30,x5      # t1 += f
    sw      x30,0(x31)      # B[g] = A[f+1] + A[f] -> result
```

5)
- little endian

|0|4|8|12|
|:-:|:-:|:-:|:-:|
|12|ef|cd|ab|


- big endian

|0|4|8|12|
|:-:|:-:|:-:|:-:|
|12|ef|cd|ab|

7)
```c
B[8] = A[i] + A[j];
```
```asm
init.       # f : x5, g : x6, h : x7, i : x28, j:x29, A : x10, B : x11
    slli    x28,x28,2
    add     x10,x10,x28
    lw      x30,0(x28)
    slli    x29,x29,2
    add     x11,x11,x29
    lw      x31,0,(x29)
    add     x30,x30,x31
    sw      x30,32(x11)
```

8)
```asm
init.       # f : x5, g : x6, h : x7, i : x28, j:x29, A : x10, B : x11
    addi    x30,x10,4   # t1 = &A[1]
    addi    x31,x10,0   # t2 = &A[0]
    sw      x31,0(x30)  # A[1] = &A
    lw      x30,0(x30)  # t1 = &A[0]
    add     x5,x30,x31  # f = &A[0] + &A[0]
```

9)
```