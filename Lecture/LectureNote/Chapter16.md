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
- for/while loop case
    - bne from i < n, addi from i++, ld from a[i], add from sum += 

2. Stack
- i, sum whatever local variables 

3. Heap
- a[i]

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

## Cache Organization

#### Direct-mapped Cache
- Problem 1 : Block Placement Policy
    - Using modulo operation for get cache idx
        - $address_{cache} = (address_{block})\ \bmod\ (number\ of\ caches)$
        - $idx = (a/b)\ \%\ (c/b)$
            - a = address, b = word size, c = cache size

- Problem 2 : How to know cache block is valid?
    - Using valid bits for cache hitted
        - 1 is not-empty
        - 0 is empty

- Problem 3 : How to know cache block contain requested data?
    - Using address tag for specifing actual address of data 

- Deal with cache miss
    - Check cache &rarr; miss or not, cycle is passed(in multi cycle structure)
    - In next cycle, access to PC - 4(PC is already incremented) if data, we don't neede PC address
    - read data/insturction from main memory and wait until done
    - write to cache(data, valid bits, tag)
    - start from first(find data in cache)

- Write handling
    - if write only cache not in main memory &rarr; conflict between cache and memory occur(**Inconsistent**)
    - solution 1 : write cache and memory at a same time(**write-through**)
        - simple but not good at a performance

    - solution 2 : **write buffer**
        - send write data to write buffer and then main memory concurrently run write operation with write buffer during other operation run in CPU

    - solution 3 : **write-back**
        - only write in cache
        - write to memory when cache data replaced

#### 