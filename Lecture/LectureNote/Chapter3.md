Integer
=======
Integer Representation
----------------------
### 1. Unsigned binary
   - Simple binary style
   - Range : $0<x<2^{w}-1$
$B2U(X) = \displaystyle\sum_{i=0}^{w - 1} 2^i*x_i$
### 2. Sign and Magnitude
   - use MSB(bits) as sign bits( x >= 0 ? 0 : 1)
$SM(X) = (-1)^{x_{w-1}}*\displaystyle\sum_{i=0}^{w - 2} 2^i*x_i$ 
   - Range : $-2^{w-1}-1<x<2^{w-1}-1$
   - Problems
     - 2 type of zero(00000..., 10000...)
     - Extra operation for sign bit 
### 3. 2's complements
$B2T(X) = -2^{w-1}*x_{w-1}+\displaystyle\sum_{i=0}^{w - 2} 2^i*x_i$ **or** $B2T(X) = -1+\displaystyle\sum_{i=0}^{w - 2} 2^i* !x_i$
   - -1 = 11111...1
   - MIN = 10000...0 = $2^{w-1}-1$
   - MAX = 01111...1 = $-2^{w-1}$
   - Range : $-2^{w-1}<x<2^{w-1}-1$

Intger Conversion and Casting
-----------------------------
### 1. Signed to Unsigned
- **Maintain bit pattern!**
  - bit pattern doesn't change during sign casting
  - So, overflow occur in some case
    - unsign to sign
      - negative to positive
    - sign to unsign
      - big positive to negative
### 2. Sign conversion
- 
### 3. Extension
- Smaller to Larger ( ex) int to long )
  - case 1. signed extension (casting to signed type)
    - In this case, extended number by sign bit(MSBit)
  - case 2. unsigned extension (extended to unsigned type)
    - In this case, extended number with 0
### 4. Truncation
- Larger to Smaller ( ex) long to int )
  - Delete upper bit
  - Doesn'y consider sign bit


Integer Operations
------------------
### 1. Bit-Level Operation
| operation | effect                   | example             |
| --------- | ------------------------ | ------------------- |
| ~         | NOT(bit-level inversion) | ~0101 = 1010        |
| &         | AND                      | 1100 & 1010 = 1000  |
| \|        | OR                       | 1100 \| 1010 = 1110 |
| ^         | XOR                      | 1100 ^ 1010 = 0110  |
### 2. Logic Operation(bool-level)
| operation | effect                     | example                                      |
| --------- | -------------------------- | -------------------------------------------- |
| !         | NOT(bool-level conversion) | !0101 = 0000, !0000 = 0001                   |
| &&        | AND                        | 1100 && 1010 = 0001, 0000 && 1010 = 0000     |
| \|\|      | OR                         | 1100 \|\| 1010 = 0001, 0000 \|\| 0000 = 0000 |
### 3. Shift Operation
| operation | effect                                         | example          |
| --------- | ---------------------------------------------- | ---------------- |
| <<        | Left shift - always fill with zero                | 1011 << 2 = 1100 |
| >>        | Right shift - logical : zero, Arithemetic : sign bits | 1011 >> 1 = 1101 |
- Signed integer : logical operation
- Unsigned integer : Arithmetic operation
### 4. Addition
- Simple binary addition : very easy
  - But have to concerned about overflow --> we will cover this in Overflow part
### 5. Multplication
- Multiply : left shift x << y &rarr; $x * 2^y$
- Divide : right shift x >> y &rarr; $x/2^y$

Overflow
--------
1. Unsigned Addition
- Occur when $ret > 2^w$
- How it works?
  - Work like modular operation
  - Ingnore carry bit
2. Signed Addition
- Occur only when two input's sign is same
  - carry bit occur != overflow occur
  - ex) $-1 -1 = 1111_{(2)} + 1111_{(2)} = 11110_{(2)} = 1110_{(2)} = -2$
    - We call this process as ignore bit
- So, overflow mean result unmatch with predicted result
- Signed overflow is different from unsigned overflow
  - When overflow occur, go to biggest/smallest(not to zero)