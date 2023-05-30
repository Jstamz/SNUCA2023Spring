Single Cycle Architecture
=========================

Parallel Architecture
=====================

Different Types of Parallelism
------------------------------
1. Coarse-grainde parallelism : multiprocessor, multicore
    - run different program for each processor
    - using 

2. Fine-grained prallelism : superscalar, VLIW processors
    - run single program but execute instruction parally

3. Pipelined Architecture
    - split work process to multiple phase
    - run independent phase in parallel

Piplelined Architectures
------------------------
- Insert register device between each phase

- Pipeline performance of n-stage pipeline
    - Latency
        - 1 instruction : $N \times T_c$
        - K instruction : $(K + N - 1) \times T_c$
    - Throughput
        - K instruction : $(K + N - 1) \times T_c / K$
        - inf instruction : $T_c$

Limitation of pipelining
------------------------
1. Non-uniform delays
- each phase's time delay is not uniform &rarr; longest time delay determine system's clock delay

2. Register Overhead
- If parallel stage increase, then more register need for computing &rarr; register time occupancy increase

3. Pieplline Hazard
- Serious problem

Pipeline Hazards
----------------
1. Structural hazards
- Simulatneous data transfer to same component
    - in RISC-V
        - load/store
        - wirte/
- Solution
    - divide memory : instruction memory / data memory
        - IF/MEM phase collision
    - divide time : negedge / posedge
2. Data hazards(Data dependency)
- wait until data changed or wait until data loaded : Arithemetic, Load
- Solution
    - stall : delay phase until job prior operation finihsed
        - but it's to slow...(not recommended)
    - Internal forwarding
        - save prior operation's result in register
        - then we can use this on next operation when they needed

3. Control hazards
- When branch operation, there is 3 cycle delay until PC adjust
- Solution
    - Branch prediction
        - after branch operation, 
    - Branch delay slot
        - we have a delay between PC update, so execute some instruction in this time slot











