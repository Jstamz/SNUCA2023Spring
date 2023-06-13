## 5.1
```c
for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8000; j++) {
        A[i][j] = A[j][i] + B[i][0];
    }
}
```
#### 5.1.1
> How many 64-bit integers can be stored in a 16-byte cache block?
- 16 bytes = 128 bits
- 128 / 64 = 2
- 2 integers can be stored in a 16-byte cache block
#### 5.1.2
> Which variable references exhibit temporal locality?
- i and j (but most case, i and j is store in register)
- B[i][0] : for 1000 times in j-loops
#### 5.1.3
> Which variable references exhibit spatial locality?
- A[i][j]
## 5.2
> Caches are important to providing a high-performance memory hierarchy to processors. 
> Below is a list of 64-bit memory address references, given as word addresses.
``` 
0x03, 0xb4, 0x2b, 0x02, 0xbf, 0x58, 0xbe, 0x0e, 0xb5, 0x2c, 0xba, 0xfd
```
#### 5.2.1
> For each of these references, identify the binary word address, the tag, and the index given a direct-mapped cache with 16 one-word blocks. Also list whether each reference is a hit or a miss, assuming the cache is initially empty.
- All try is missed
  | Index |  Tag  | Valid | Word address |
  | :---: | :---: | :---: | :----------: |
  |  0x1  | None  |   0   |      0       |
  |  0x2  |  0x0  |   1   |     0x02     |
  |  0x3  |  0x0  |   1   |     0x03     |
  |  0x4  |  0xb  |   1   |     0xb4     |
  |  0x5  |  0xb  |   1   |     0xb5     |
  |  0x6  | None  |   0   |      0       |
  |  0x7  | None  |   0   |      0       |
  |  0x8  |  0x5  |   1   |     0x58     |
  |  0x9  | None  |   0   |      0       |
  |  0xa  |  0xb  |   1   |     0xba     |
  |  0xb  |  0x2  |   1   |     0x2b     |
  |  0xc  |  0x2  |   1   |     0x2c     |
  |  0xd  | None  |   0   |      0       |
  |  0xe  |  0x0  |   1   |     0x0e     |
  |  0xf  |  0xf  |   1   |     0xfd     |
#### 5.2.2
> Repeat the previous problem for a direct-mapped cache with 8 two-word blocks.

| Index |  Tag  | Valid | offset 1 | Word address 1 | offset 2 | Word address 2 |
| :---: | :---: | :---: | :------: | :------------: | :------: | :------------: |
|  0x0  |   0   |   0   |    0     |       0        |    0     |       0        |
|  0x1  |  0x0  |   1   |    0     |      0x02      |    1     |      0x03      |
|  0x2  |  0x0  |   1   |    0     |      0xb4      |    1     |      0xb5      |
|  0x3  |  0xb  |   0   |    0     |       0        |    0     |       0        |
|  0x4  |  0x5  |   1   |    0     |      0x58      |    0     |       0        |
|  0x5  |  0xb  |   1   |    0     |      0xba      |    1     |      0xbb      |
|  0x6  |  0xf  |   1   |    0     |      0xfc      |    1     |      0xfd      |
|  0x7  |  0x0  |   1   |    0     |      0x0e      |    1     |      0x0f      |
1. 0x03 - Miss
2. 0xb4 - Miss
3. 0x2b - Miss
4. 0x02 - Hit! (store when access to 0x03)
5. 0xbf - Miss
6. 0x58 - Miss
7. 0xbe - Hit! (store when access to 0xbf)
8. 0x0e - Miss
9. 0xb5 - Hit! (store when access to 0xb4)
10. 0x2c - Miss
11. 0xba - Miss
12. 0xfd - Miss
#### 5.2.3

## 5.3
> By convention, a cache is named according to the amount of data it contains (i.e., a 4 KiB cache can hold 4 KiB of data); however, caches also require SRAM to store metadata such as tags and valid bits. For this exercise, you will examine how a cache’s configuration affects the total amount of SRAM needed to implement it as well as the performance of the cache. For all parts, assume that the caches are byte addressable, and that addresses and words are 64 bits.
#### 5.3.1 
> Calculate the total number of bits required to implement a 32 KiB cache with two-word blocks.
- Set size
  - $32 KiB = 2^5 \times 2^{10} = 2^{15}$
  - Set size = Cache size / Block size = $2^{15} / 2^4 = 2^{11}$
  - Index bits = $\log_2 2^{11} = 11$
- 2 Word Block
  - Offset bits = $\log_2 2^4 = 4$
- So, one cache block need...
  - 1 Tag bit : 64 - 11 - 4 = 49
  - 1 Valid bit : 1
  - Data field : 64 * 2 = 128
  - Total Size : $2^{11} \times (49 + 1 + 128)$

#### 5.3.2 
> Calculate the total number of bits required to implement a 64 KiB cache with 16-word blocks. How much 960 bigger is this cache than the 32 KiB cache described in Exercise 5.3.1? (Notice that, by changing the block size, we doubled the amount of data without doubling the total size of the cache.)
- Set size
  - $64 KiB = 2^6 \times 2^{10} = 2^{16}$
  - Set size = Cache size / Block size = $2^{16} / 2^7 = 2^{9}$
  - Index bits = 9
- 16 Word Block
  - Offset bits = $\log_2 2^7 = 7$
- So, one cache block need...
  - 1 Tag bit : 64 - 9 - 7 = 48
  - 1 Valid bit : 1
  - Data field : 64 * 16 = 1024
  - Total Size = $2^{9} \times (1024 + 1 + 48)$
#### 5.3.3 
> Explain why this 64 KiB cache, despite its larger data size, might provide slower performance than the first cache.
- With large block size, we can more efficiently utilize the spatial locality of the program.
- But, it also increase cache access time and miss penalty.

## 5.5
|  Tag  | Index | Offset |
| :---: | :---: | :----: |
| 63-10 |  9-5  |  4-0   |
#### 5.5.1
> What is the cache block size (in words)?
- offset size is basically $log(Block\ Size)$
- So, block size is $2^{5} = 32B$
- So, block contain $32B/8B = 4$ words
#### 5.5.2
> How many blocks does the cache have?
- Index bits = $log(Block\ number)$
- So, there is 2^5 = 32 blocks in cache
#### 5.5.3
> What is the ratio between total bits required for such a cache implementation over the data storage bits? Beginning from power on, the following byte-addressed cache references are recorded.
- Data field size = 32 * 4 * 64 = 8192bits
- Total size = $2^5 \times (54 + 1 + 64 \times 4)$

## 5.7 : Must to do in later...

#### 5.7.1
> Suppose a CPU with a write-through, writeallocate cache achieves a CPI of 2. What are the read and write bandwidths (measured by bytes per cycle) between RAM andthe cache? (Assume each miss generates a request for one block.)
- 0.003 * 1 * 64 / x
- 0.25 * 0.02 * 64 * 1 / x
- 0.1 * 0.02 * 64 * 1 / x
- total = 
#### 5.7.2
> For a write-back, write-allocate cache, assuming 30% of replaced data cache blocks are dirty, what are the read and write bandwidths needed for a CPI of 2?


#### 5.8
Assumption : 64-bit Word, linear address access, 512KiB array

#### 5.8.1
> 32B Block size, 64 KiB Cache size, direct-mapped cache
- 32B block size &rarr; 4 words per block
  - offset bits = 2
- 64 KiB cache size &rarr; 2^6 x 2^10 = 2^16
  - index size = 2^11
  - tag size = 64 - 11 - 2 = 51
- Miss rate =  0.25
  - 1 Block can contain 4 words so, each 1 miss we cache 4 words
  - So, miss rate = 1/4 = 0.25
- Miss cause : compulsory miss and capacity miss
  - Because, we assume that cache is empty at first
  - Array size bigger than cache size, we can't cache all data

#### 5.8.2
> Compare direct-mapped cache's miss rate with 16B Block size, 64B Block size, 128B Block size
1. 16B : 0.5
2. 64B : 0.125
3. 128B : 0.0625

## 5.9
- Miss Rate Table
  | Block Size(B) |   8   |  16   |  32   |  64   |  128  |
  | :-----------: | :---: | :---: | :---: | :---: | :---: |
  |   Miss Rate   |  4%   |  3%   |  2%   | 1.5%  |  1%   |
- Load per instruction : 1.35(Data + Instruction)
  - So, pure data load per instruction is 0.35
#### 5.9.1
> If miss penalty is 20 $\times$ B Cycles, what is optimal block size?

Average Memory Access Time(AMAT)
  - AMAT = Hit Time + Miss Rate $\times$ Miss Penalty 

1. 8B = 20 * 8 = 160
  - AMAT = 160 * 0.04 = 6.4
2. 16B = 20 * 16 = 320
  - AMAT = 320 * 0.03 = 9.6
3. 32B = 20 * 32 = 640
  - AMAT = 640 * 0.02 = 12.8
4. 64B = 20 * 64 = 1280
  - AMAT = 1280 * 0.015 = 19.2
5. 128B = 20 * 128 = 2560
  - AMAT = 2560 * 0.01 = 25.6

So, 8B is optimal block size

#### 5.9.2
> If miss penalty is 24 + B Cycles, what is optimal block size?

1. 8B = 24 + 8 = 32
  - AMAT = 32 * 0.04 = 1.28
2. 16B = 24 + 16 = 40
  - AMAT = 40 * 0.03 = 1.2
3. 32B = 24 + 32 = 56
  - AMAT = 56 * 0.02 = 1.12
4. 64B = 24 + 64 = 88
  - AMAT = 88 * 0.015 = 1.32
5. 128B = 24 + 128 = 152
  - AMAT = 152 * 0.01 = 1.52

So, 32B is optimal block size

#### 5.9.3
> If miss penalty is 100 cycles, what is optimal block size?

1. 8B = 100
  - AMAT = 100 * 0.04 = 4
2. 16B = 100
  - AMAT = 100 * 0.03 = 3
3. 32B = 100
  - AMAT = 100 * 0.02 = 2
4. 64B = 100
  - AMAT = 100 * 0.015 = 1.5
5. 128B = 12800
  - AMAT = 100 * 0.01 = 1

So, 128B is optimal block size

## 5.10 - Important problem!
- Assumption
  - Main memory access time = 70ns
  - Memory load per instruction = 0.36
- Cache parameters
  |  CPU  | L1 Size | L1 Miss Rate | L1 Hit time |
  | :---: | :-----: | :----------: | :---------: |
  |  P1   |  2 KiB  |      8%      |   0.66ns    |
  |  P2   |  4 KiB  |      6%      |   0.90ns    |

#### 5.10.1
> if L1 access time of each cache define cycle time of CPU, what is the frequency of each CPU?

1. P1
  - 0.66ns = 1.515GHz
2. P2
  - 0.90ns = 1.111GHz

#### 5.10.2
> What is AMAT of P1, P2?

AMAT = Hit time + Miss Rate $\times$ Miss Penalty

1. P1
  - 1 + 0.08 * 70 / 0.66 = 9.485 Cycles
2. P2
  - 1 + 0.06 * 70 / 0.90 = 5.667 Cycles

#### 5.10.3
> What is the CPI of each CPU?

CPI : base CPI + Memory cache miss penalty + Data cache miss penalty

1. P1
  - 1(Base CPI) + 0.08 * 107(Data cache miss penalty) + 0.36 * 0.08 * 107(Memory cache miss penalty) = 12.64
2. P2
  - 1(Base CPI) + 0.06 * 78(Data cache miss penalty) + 0.36 * 0.06 * 78(Memory cache miss penalty) = 7.36

#### Additional Condition
| L2 Size | L2 Miss Rate | L2 Hit time |
| :-----: | :----------: | :---------: |
|  1MiB   |     95%      |   5.62ns    |

#### 5.10.4
> Recalculate AMAT of P1

AMAT for multiple cache
  - Hit time 1 + Miss Rate 1 * (Hit time 2 + Miss Rate 2 $\times$ Miss Penalty)

P1 : 1 + 0.08 * (5.62 / 0.66 + 0.95 * 70 / 0.66) = 9.742

#### 5.10.5
> Recalculate CPI of P1

P1 : 1 + 0.08 * (9 + 0.95 * 107) + 0.36 * 0.08 * (9 + 0.95 * 107) = 13.04

## 5.11 
> Memory access sequence
> 0x03, 0xb4, 0x2b, 0x02, 0xb3, 0x58, 0xbf, 0x0e, 0x1f, 0xb5, 0xbf, 0xba, 0x2e, 0xce

#### 5.11.1
> Cache Setting
> Block size : 2 word(16B)
> Cache size : 48 word(384B)
> Cache Type : 3-way set associative

- Cache parameters
  - Sets : 48 / (2 * 3) = 8 &rarr; 3 bits
  - Block offset : 2 &rarr; 1 bit
  - Tag : 8 - 3 - 1 = 4-bits

#### 5.11.2
1. 0x03 &rarr; 0000 0011
  - Tag : 0000 = 0x0
  - Index : 001 = 1
  - Block offset : 1
  - Miss! &rarr; 0x02, 0x03 saved in line 1, way 0
2. 0xb4 &rarr; 1011 0100
  - Tag : 1011 = 0xb
  - Index : 010 = 2
  - Offset : 0
  - Miss! &rarr; 0xb4, 0xb5 saved in line 2, way 0
3. 0x2b &rarr; 0010 1011
  - Tag : 0010 = 0x2
  - Index : 101 = 5
  - Offset : 1
  - Miss! &rarr; 0x2a, 0x2b saved in line 5, way 0
4. - 0x02 &rarr; 0000 0010
  - Tag : 0000 = 0x0
  - Index : 001 = 1
  - Offset : 0
  - Hit! &rarr; 0x02 saved in line 1, way 0, offset 0, saved when 0x03 requseted

## 5.12
| Base CPI | Clock | Memory access time | L1 Miss Rate | DL-L2 Access time | DL-L2 Miss Rate | 8-way-L2 Access time | 8-way-L2 Miss Rate |
| :------: | :---: | :----------------: | :----------: | :---------------: | :-------------: | :------------------: | :----------------: |
|   1.5    | 2GHz  |       100ns        |      7%      |     12 Cycle      |      3.5%       |       28 Cycle       |        1.5%        |

#### 5.12.1
> Calculate CPI
> 1. only use L1
> 2. use L1 + DL L2
> 3. use L1 + 8-way L2 + double memory access time

1. 1.5 + 0.07 * 200 = 15.5
2. 1.5 + 0.07 * (12 + 0.035 * 200) = 2.83
3. 1.5 + 0.07 * (28 + 0.015 * 200) = 3.67

Double memory case

1. 1.5 + 0.07 * 400 = 29.5
2. 1.5 + 0.07 * (12 + 0.035 * 400) = 3.32
3. 1.5 + 0.07 * (28 + 0.015 * 400) = 3.88

#### 5.12.2
> Add L3 Cache which has 50 cycle access time and 13% miss rate
> Caculate CPI of L1 + DL L2 case

CPI = 1.5 + 0.07 * (12 + 0.035 * (50 + 0.13 * 200)) = 2.53
  - Yes! it improve CPI