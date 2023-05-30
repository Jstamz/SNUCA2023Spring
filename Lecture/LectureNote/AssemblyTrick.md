Arithemetic Trick
=================
Loading Big Immediate Value
---------------------------
- using lui and addi
    - ex) want to load 0x12345678 in int a
    ```asm
        lui     a0, 0x12345     # save 0x12345 in highest 5 byte of a
        addi    a0,a0,0x678     # add 0x678 to make low 3 byte of a as a0
    ```

Multiply Constant Value
-----------------------
- use shift and
```asm
    add     a5,a4,a0    # a5 = a4 + a           (p1 = 3*a)
    slli    a5,a5,4     # a5 = a5 << 4          (p1 = 48*a)
    slli    a0,a1,3     # a0 = b << 3           (a = b*8)
    add     a0,a0,a1    # a0 += b               (a = b*9)
    slli    a0,a0,2     # a0 = a0 << 2          (a = b*36)
    add     a5,a5,a0    # a5 += a0              (p1 = 48*a + 36*b)
```