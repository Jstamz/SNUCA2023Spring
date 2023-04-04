RISC-V Machine-Level Programming Basics
=======================================

The HW/SW Interface
-------------------
### 1.

### 2.

RISC-V Instruction Set Architecture
-----------------------------------
### 1. The RISC-V Instruction Set
+ Open source!
+ Versions
  + RV32I, RV64I, RV128I : 32-bits, 64-bits, 128-bits
  + RV32E : reduced version of RV32I
    + with 16 registers for embedded system(normally 32 reigsters)
  
### 2. Registers : 32th registers
| Register name | Symbolic name | Description                                                                                                                 | Saved By |
| ------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------- | -------- |
| x0            | zero          | Always zero - Thrash can of memory                                                                                          | Caller   |
| x1            | ra            | Return address - Save return address of function                                                                            | Callee   |
| x2            | sp            | Stack pointer - first addres of stack frame                                                                                 | Callee   |
| x3            | gp            | Global pointer - Save global variable memory area adress                                                                    |          |
| x4            | tp            | Thread pointer - Current thread's address or divide stack frame for multi-thread programming                                |          |
| x5            | t0            | Temporary / alternate return address                                                                                        | Caller   |
| x6-7          | t1-2          | Temporary                                                                                                                   | Caller   |
| x8            | s0/fp         | Saved register / frame pointer - last addres of stack frame                                                                 | Callee   |
| x9            | s1            | Saved register                                                                                                              | Callee   |
| x10-11        | a0-1          | Function argument / return value - Save function argument in calling process, and save output of function in return process | Caller   |
| x12-17        | a2-7          | Function argument                                                                                                           | Caller   |
| x18-27        | s2-11         | Saved register                                                                                                              | Callee   |
| x28-31        | t3-6          | Temporary                                                                                                                   | Callee   |
- Caller is orgin process that call callee : ex) main 
- Callee is function that called by caller : ex) printf
  
### 3. Data Types
- Integer(1, 2, 4, 8) / Floating point(4, 8)
- Not define **aggregated types** : ex) array

### 4. RISC-V Addressing
- Immdeiate Addressing
  - Save argument(actual data) in operation's code
- Register Addressing
  - Save argument inside register and pointing that register(using register address)
- Base Addressing
  - Operation code reference to regsiter that save address of memory which contain argument
- PC-relative Addressing
  - Addressing data inside memory by using relative address of PC's address

Translate Program & Execute
---------------------------
### 1. Compiler
- C program to assembly language program
- gcc -march=rv32i -mabi-ilp32 -O0 -S sum.c
- riscv64-unknown-elf-gcc -march=rv32i -mabi-ilp32 -O -S sum.c

### 2. Assembler
- Assembly language to Machine language
- Optimization Example
  - mv x10, x11 &rarr; move x11 data to x10
  - equal to addi x10, x11, 0 %rarr; x10 = x11 + 0

### 3. Linker

RISC-V Operations & Operands
----------------------------
### 1. Opeartions : only work between registers
1. Arithmetic

| Instruction                 | Type  | Example              | Meaning                                  |
| :-------------------------- | :---: | :------------------- | :--------------------------------------- |
| Add                         |   R   | add rd, rs1, rs2     | R[rd] = R[rs1] + R[rs2]                  |
| Subtract                    |   R   | sub rd, rs1, rs2     | R[rd] = R[rs1] - R[rs2]                  |
| Add imm.                    |   I   | addi rd, rs1, imm12  | R[rd] = R[rs1] + SignExt(imm12)          |
| Set less than               |   R   | slt rd, rs1, rs2     | R[rd] = (R[rs1] < R[rs2])? 1 : 0         |
| Set less than imm.          |   I   | slti rd, rs1, imm12  | R[rd] = (R[rs1] < SignExt(imm12))? 1 : 0 |
| Set less than unsigned      |   R   | sltu rd, rs1, rs2    | R[rd] = (R[rs1] < R[rs2])? 1 : 0         |
| Set less than imm. unsigned |   I   | sltiu rd, rs1, imm12 | R[rd] = (R[rs1] < SignExt(imm12))? 1 : 0 |
| Load upper imm.             |   U   | lui rd, imm20        | R[rd] = SignExt(imm20 << 12)             |
| Add upper imm. to PC        |   U   | auipc rd, imm20      | R[rd] = PC + SignExt(imm20 << 12)        |

    ex) f = (g + h) - (i + j);
      add  t0  i   j
      add  t1  g   h
      sub  f   t0  t1
2. Logical

| Instruction                 | Type  | Example             | Meaning                          |
| :-------------------------- | :---: | :------------------ | :------------------------------- |
| AND                         |   R   | and rd, rs1, rs2    | R[rd] = R[rs1] & R[rs2]          |
| OR                          |   R   | or rd, rs1, rs2     | R[rd] = R[rs1] \| R[rs2]         |
| XOR                         |   R   | xor rd, rs1, rs2    | R[rd] = R[rs1] ^ R[rs2]          |
| AND immediate               |   I   | andi rd, rs1, imm12 | R[rd] = R[rs1] & SignExt(imm12)  |
| OR immediate                |   I   | ori rd, rs1, imm12  | R[rd] = R[rs1] \| SignExt(imm12) |
| XOR immediate               |   I   | xori rd, rs1, imm12 | R[rd] = R[rs1] ^ SignExt(imm12)  |
| Shift left                  |   R   | sll rd, rs1, rs2    | R[rd] = R[rs1] << R[rs2]         |
| Shift right logical         |   R   | srl rd, rs1, rs2    | R[rd] = R[rs1] >> R[rs2]         |
| Shift right arithmetic      |   R   | sra rd, rs1, rs2    | R[rd] = R[rs1] >> R[rs2]         |
| Shift left logical imm.     |   U   | slli rd, rs1, shamt | R[rd] = R[rs1] << shamt          |
| Shift right logical imm.    |   U   | srli rd, rs1, shamt | R[rd] = R[rs1] >> shamt          |
| Shift left arithemetic imm. |   U   | srai rd, rs1, shamt | R[rd] = R[rs1] >> shamt          |

3. Save/Load
 - load byte(1-byte), halfword(2-byte), word(4-byte), doubleword(8-byte)
 - Extension rule
   - in 64-bits system &rarr; byte to word load doesn't match with register's size
     - must extend!
   - for this extension we have to seperate to type of loading 
   - cf) in 32-bits system, we can't use ld for loading data(32-bits register)
   - 
| Instruction            | Type  | Example            | Meaning                                       |
| :--------------------- | :---: | :----------------- | :-------------------------------------------- |
| Load doubleword        |   I   | ld rd, imm12(rs1)  | R[rd] = Mem[R[rs1]+ SignExt(imm12)]           |
| Load word              |   I   | lw rd, imm12(rs1)  | R[rd] = SignExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Load halfword          |   I   | lh rd, imm12(rs1)  | R[rd] = SignExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Load byte              |   I   | lb rd, imm12(rs1)  | R[rd] = SignExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Load word unsigned     |   I   | lwu rd, imm12(rs1) | R[rd] = ZeroExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Load halfword unsigned |   I   | lhu rd, imm12(rs1) | R[rd] = ZeroExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Load byte unsigned     |   I   | lbu rd, imm12(rs1) | R[rd] = ZeroExt( Mem[R[rs1]+ SignExt(imm12)]) |
| Store doubleword       |   S   | sd rs2, imm12(rs1) | R[rs2] = Mem[R[rs1]+ SignExt(imm12)]          |
| Store word             |   S   | sw rs2, imm12(rs1) | R[rs2] = Mem[R[rs1]+ SignExt(imm12)]          |
| Store halfword         |   S   | sh rs2, imm12(rs1) | R[rs2] = Mem[R[rs1]+ SignExt(imm12)]          |
| Store byte             |   S   | sb rs2, imm12(rs1) | R[rs2] = Mem[R[rs1]+ SignExt(imm12)]          |
### 2. Operands
1. Memory operands
   1. lw(load word)
      - lw destination, source(base register(register that save start address) + offset(kind of index))
      - ex) g = h + A[8] : g &rarr; x20, h &rarr; x21, A's start address &rarr; x22
        - lw   x9, 32(x22) &rarr; load data from x22 + 8 * word_size to x9 register
        - add  x20, x21, x9
   2. sw(store word)
       - sw source, destination &rarr; source's addressing same as lw's
       - ex) A[12] = h + A[8] : h &rarr; x21, A's start address &rarr; x22
         - lw  x9, 32(x22)
         - add x9, x20, x9
         - sw  x9, 48(x22)
   - Key point : memory address always behind register!!!!!

2. Constant/Immediate operands
- if we can't use immediate operands, then code perform like this
- ex) h += 4; &rarr; h : x22
  - lw  x9, AddrConstant4(x3) &rarr; save literal value to register
  - add x22, x22, x9
- By using immediate operands, we can skip lw process
  - addi    x22, x22, 4(immediate value)

- Key points : purpose of zero-register &rarr; by sub regsiter with zero-register, with can easily convert sign of register data

### 3. Opeartion Expression
- RISC-V's instruction length == 32-bits(word size)
- We encode operation like add x9, x22, x9 to byte code(machine language)
- for that translation, ISA offer some format of operation
 
1. Filed of Operations
    1. Register case : R-type

    | funct7 |  rs2   |  rs1   | funct3 |   rd   | opcode |
    | :----: | :----: | :----: | :----: | :----: | :----: |
    | 7-bits | 5-bits | 5-bits | 3-bits | 5-bits | 7-bits |
    - opcode : operation code
    - rd     : destination register
    - funct3 : extra opcodee
    - rs1    : source register 1
    - rs2    : source register 2
    - funct7 : extra opcode
 
    2. Immediate case : I-type
   
    | immediate |  rs1   | funct3 |   rd   | opcode |
    | :-------: | :----: | :----: | :----: | :----: |
    |  12-bits  | 5-bits | 3-bits | 5-bits | 7-bits |
    - immediate : save immediate value(two's complement) &rarr; $-2^{11}< x < 2^{11}-1$

    3. Store/Load case : S-type

    | immediate[11:5] |  rs2   |  rs1   | funct3 | immediate[4:0] | opcode |
    | :-------------: | :----: | :----: | :----: | :------------: | :----: |
    |     7-bits      | 5-bits | 5-bits | 3-bits |     5-bits     | 7-bits |
    - divide immediate array for pattern matching with R-type
    - ex) lw  x9,  32(x22)
      - lw &rarr; opcode
      - x9 &rarr; rd
      - 32 &rarr; immediate
      - x22 &rarr; rs1
    4. Upper Immediate : U-type
   
    | immediate |   rd   | opcode |
    | :-------: | :----: | :----: |
    |  20-bits  | 5-bits | 7-bits |
    - lui, auipc matching with this type
    - ex) lui x6, 0x12345
      - lui &rarr; opcode
      - x6 &rarr; rd
      - 0x12345 &rarr; immediate
      - result &rarr; x6 : 0x12345000
    - Interesting way to store immediate using lui
      - guess we want to store 0x12345678 in x7
      - lui   x7, 0x12345 &rarr; x7 : 0x*12345*000
      - addi  x7, x7, 0x678 &rarr; x7 : 0x12345*678*
2. s