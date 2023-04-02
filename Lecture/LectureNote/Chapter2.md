Data Representation
===================

Byte-Oriented VS Word-Oriented
------------------------------
### 1. Byte-Oriented Memory Organization
- Consider memory as Byte-unit array
  - ex) 
    | 0   | 1   | 2   | ... | FF  |
    | --- | --- | --- | --- | --- |
    | 0   | 0   | 1   | ... | 1   |
### 2. Word-Oriented Memory Organization
- Consider memory as big **block** : we call this size as **word**
  - ex)
    | 0       | 1   | ... | 8       | 9   | ... | F1      | F2  | ... |
    | ------- | --- | --- | ------- | --- | --- | ------- | --- | --- |
    | 0 0 ... |     |     | 1 1 ... |     |     | 1 1 ... |     |     |
- Specify word by first byte's address

Data Types
----------
### 1. Integer
- long : 4byte in 32-bit, 8byte in 64-bit
- 
### 2. Floating Point
- long : 4byte in 32-bit, 8byte in 64-bit

### 3. Pointers
- pointer
  - 32-bits : 4 bytes
  - 64-bits : 8 bytes

### 4. Strings
- Representation method
  1) as
  2) as
  3) NULL terminate : mark end of string array as '\0' character

Byte Ordering
-------------
1. MSB & LSB
   - MSB
     - Last byte of data(left byte)
   - LSB
     - First byte of data(right byte)
2. Big endian
   - MSB first 
   - ARM, PowerPC, the Internet
     - ex) 0x12345678  

    | 0 | 1 | 2 | 3 |
    |---|---|---|---|
    | 12| 34| 56| 78|
3. Little endian 
   - LSB first(L-L)
   - Intel, RISC-V
     - ex) 0x12345678

    | 0 | 1 | 2 | 3 |
    |---|---|---|---|
    | 78| 56| 34| 12|

Source Code to Machine Language
-------------------------------
### 1. Preprocessing
- handle preprocessor directive
    - ex) '#' codes - #include, #define, #ifdef... etc
- Duplicate header's to source code, switch define character to actual value, ... etc
- gcc -E main.c > main.pp.c
    - result main.pp.c
### 2. Compiling
- C code to assembly
- gcc -S main.pp.c
    - result main.pp.s
### 3. Assembling
- Assembly code machine lanaguage(hex digit array)
- gcc -c main.pp.s
  - result main.pp.o
### 4. Linking
- After the assembling process, all the source code has their own object file(.o)
  - We have to link those files further included source files too
- What we learn in hacking(PLT, GOT) is created in this process
  - Dyanmic Link(PLT, GOT)
  - Static Link(actually copying machine language to each source code)