# Cache Memories

## Memory Wall
- While single-core performance of CPUs has improved tremendously, reaching a point where there is no room for further improvement
  - Acutally after 2003, P-4 is the last single core CPU that improve it's clock cycle
    - Because of **Power Wall**
  - After that, most of CPU companies try to design their product as multi core-thread 
  - But, DRAM speeds are still close to 1000x that of CPU's single core.

- even though performance difference between single core and DRAM still bigger, DRAM have to support more cores
  - Now aday, intel's CPU construct with 24 cores(8 performace, 16 efficient)

## Locality of Reference
1. **Temporal locality** : recently referenced items are likely to be referenced again in the near future

2. **Spatial locality** : items with nearby referenced items are likely to be referenced in the near future

#### What we have to considering?
```c
int sum = 0;
for (int i = 0; i < n; i++)
    sum += a[i];
```
1. Instruction
2. Stack
3. Heap

#### Solution : Memory Hierarchies
- By storing recently called instruction or data near processor, we can materialize concepts of locality

## Cache
- Cahce is...
  - computer memory with very short access time to temporary store frequently or recently used or locate nearby those data or instruction

#### General Concepts
- if some device request data from memory...
  - First check cache memory
  - if data inside cache...(**hit**)
    - return data
  - else...(**miss**)
    - access to data inside memory and **update cache** and transfer to device

#### Type of Cache Misses
1. Cold miss : cache miss due to initial state(cache start with empty state)

2. Conflict miss : associativity problem - kind of hash error...

3. Capacity miss : active data/insturction is larger than cache size

#### Problem of cache
1. **Block Placement Policy** : Where can a block be placed

2. **Block Identification Policy** : How is block found?

3. **Block Replacement Policy** : Which block should be replaced on a miss?

4. **Write Strategy** : What happens on a write

## Direct-mapped Cache

#### Block Placement Policy
- Using modulo operation for get cache idx
  - $address_{cache} = (address_{block})\ \bmod\ (number\ of\ caches)$
  - $idx = (a/b)\ \%\ (c/b)$
    - a = address, b = word size, c = cache size

#### How to know cache block is valid?
- Using valid bits for cache hitted
  - 1 is not-empty
  - 0 is empty

#### How to know cache block contain requested data?
- Using address tag for specifing actual address of data 

#### Deal with cache miss
- Check cache &rarr; miss or not, cycle is passed(in multi cycle structure)
- In next cycle, access to PC - 4(PC is already incremented) if data, we don'tneede PC address
- read data/insturction from main memory and wait until done
- write to cache(data, valid bits, tag)
- start from first(find data in cache)
#### Write handling
- if write only cache not in main memory &rarr; conflict between cache and memory occur(**Inconsistent**)
- solution 1 : write cache and memory at a same time(**write-through**)
  - simple but not good at a performance
- solution 2 : **write buffer**
  - send write data to write buffer and then main memory concurrently run write operation with write buffer during other operation run in CPU
- solution 3 : **write-back**
  - only write in cache
  - write to memory when cache data replaced

## Fully Associative Cache
- Allow a datum to be saved in any cache location

#### Detail
- Cache is divided into three parts
  - **Valid bit** : check cache is empty or not
  - **Tag** : address of data
  - **Data** : actual data

- Cache hit
  - check valid bit
  - check tag
  - if hit, return data
  - if not, cache miss

- Problem
  - complex and slow
    - compare all tag in cache
    - if cache size is large, it takes long time to compare all tag

## N-way Set Associative Cache
- Allow a datum to be saved in a restricted set of cache locations
- Hybrid of direct-mapped and fully associative cache

#### Division of address
- Full address &rarr; block address + offset &rarr; tag + index + offset
  - tag : address of data
  - index : which set of cache(1st dimension of cache)
  - offset : which word of cache(2nd dimension of cache)

- Example 1
  - full address : 48 bit
  - cache spec
    - capcitiy : 32KB
    - 64B per block
    - 2-way set associative
  - cache analysis
    - offset : 6 bits
      - cache block size is $6$
    - number of set : 8 bits
      - $32KB / 64B / 2 = 256 = 2^8$
    - tag : 34 bit
    - tag overhead : 32K / 64 * 34 = 2,176B (6.25%)

- Example 2
  - full address : 48 bit
  - cache spec
    - capcitiy : 32KB
    - 64B per block
    - 8-way set associative
  - cache analysis
    - offset : 6 bits
      - cache block size is $6$
    - number of set : 6 bits
      - $32KB / 64B / 8 = 64 = 2^6$
    - tag : 36 bit
    - tag overhead : 32K / 64 * 36 = 2,304B (7.03%)

#### Block Placement & Identification
- Block Placement
  - $number\ of\ set = cache\ size / (size\ of\ block \times degree\ of\ cache)$
  - $index = (address\ of\ block / size\ of\ block)\ \%\ (number\ of\ set)$
  - $tag = address\ of\ block / (size\ of\ block \times number\ of\ set)$

- Block Identification process
  1. get tag, index, offset from address
  2. based on index, get all cache block that maching with index and valid bit is 1
  3. get block that maching with tag
  4. using offset, get data from block

#### Replacement Policy
- Situation
  - if cache is full, we have to replace some block
  - which block should be replaced?

- Strategy
  - **Random** : randomly choose block
  - **LRU** : Least Recently Used
    - choose block that not used for longest time
    - need to additional hardware for check time
  - **MRU** : Most Recently Used
    - choose block that used recently
    - need to additional hardware for check time
  - **LFU** : Least Frequently Used
    - choose block that used least frequently
    - need to additional hardware for check frequency

#### Tree Psuedo LRU
- Victim search : follow tree
  - 0 means left, 1 means right

- Cache access
  - if from left, set 1
  - if from right, set 0

