Floating Point
==============
Representation
--------------
### 1. Fractional Binary
|$d_6$|$d_5$|$d_4$|$d_3$|$.$|$d_2$|$d_1$|$d_0$|
|---|---|---|---|---|---|---|---|
|$2^3$|$2^2$|$2^1$|$2^0$||$2^{-1}$|$2^{-2}$|$2^{-3}$|
- $B2F(X) = \Sigma_{i=-n}^m 2^i*Bit(i)$
- ex)
    - $1.5 = 0001.100_{(2)}$
    - $1.375 = 0001.011_{(2)}$

### 2. Floating Point Format
- 32-bit floating point
    - sign - 1bits, exp - 8bits, frac - 23bits
- 64-bit floating point
    - sign - 1bits, exp - 11bits, frac - 52bits
1) Normalized Values : most case
- $E = exp - Bias(23-bits : 127, 64-bits : 1023)$
- $M = 1.frac$ &rarr; $frac + 1$ 
- $Value = 1.frac * 2^E$
- ex) -4.875

|$sign$|$exp$|$frac$|
|:---:|:---:|:---:|
|1|10000001|001110...|
|$Negative$|$129 - 127  = 2$|$1.001110...$|
2) Denormalized Vlaues : extremly small case
- skip
3) Special Values
- Zero : set all bits 0
- Nan : all exp set 1
- Infinity : set exp all 1 & set frac 0
    - Classify -Inf, +Inf with sign bit

Operations
----------
### 1. Rounding
- Round to even(most important)
    - 1.BBB<span style="color:red">GRS</span>...
        - G(Guard bit) - decide 0.5
        - R(Round bit) - decide round to even or not
        - S(Sticky bit) - ignore
    - case(GR)
        - 11 : over 0.5 - Up
            - delete lower bits and add 1 bit
        - 10 : round  to even
            - if 1 : delete and add 1 bits 
            - else 0 : delete lower bits
        - 0X : less 0.5 - Down
            - delete lower bits
    
### 2. Addition

### 3. Multiplication