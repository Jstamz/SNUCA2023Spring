Procedure
==========
Runtime Stack
-------------
```asm
addi    sp, sp, -<amount>
sd      ra, 0(sp)
sd      s0, 8(sp)
sd      s1, 16(sp)
...
...
ld      s1, 16(sp)
ld      s0, 8(sp)
ld      ra, 0(ra)
addi    sp, sp, <amount>
```


Procedure Call/Return
----------------------
1. Procedure Call
- using *call* as psuedo operation
    - call \<label> : set PC = label
- actually using *jal* operation
    - jal ra, \<label> : goro .label and save next inst address to ra(return address)

2. Procedure Return
- usnig *ret* as psuedo operation
    - ret : set PC = return address
- using *jalr* operatioin
    - jalr x0, 0(ra) : save address in x0(dumping) and return to ra

Save Local Variable(Calling Convention)
---------------------------------------
- local variable usally saved in stack, register, eliminated
1. Register saving convention
- Caller Save
    - *ra*, temp register
- Callee Save
    - *sp*, s register
    - register data saved in stack frame
- exception : a registers(used for parameter pass / get return value)
