```c
int f;

f = (g + h) - (i + j);
return f;
```

```assembly
addi    sp, sp, -12 // move stack frame for save current register's value
sw      x5, 8(sp)   // save current value of x5, x6, x20 register
sw      x6, 4(sp)
sw      x20, 0(sp)

add     x5, x10, x11    // x5 = g + h
add     x6, x12, x13    // x6 = i + j
sub     x20, x5, x6     // x20 = x5 = x6

addi    x10, x20, 0     // set return value(x10) as result

lw      x5, 8(sp)   // restore saved value from register
lw      x6, 4(sp)
lw      x20, 0(sp)

jair    x0, 0(x1) // return to main processor
```

```c
int fact(int n)
{
    if(n < 1) return (1);
    else return (n * fact(n-1));
}
```

```assembly
fact:
    addi    sp, sp, -4
    sw      x1, 4(sp) // save return argument
    sw      x10, 0(sp) // save argument n

    addi    x5, x10, -1
    bge     x5, x0, L1

    // smaller then 1
    addi    x10, x0, 1
    addi    x0, 0(x1)
    jair    x0, 0(x1) 

L1. // bigger than 1
```