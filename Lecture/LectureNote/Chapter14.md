<!-- vscode-markdown-toc -->
* 1. [Data Hazards](#DataHazards)
		* 1.1. [Arithemtic Hazard](#ArithemticHazard)
		* 1.2. [Load Hazard](#LoadHazard)
* 2. [Control Hazards](#ControlHazards)
* 3. [Exceptions](#Exceptions)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->
##  1. <a name='DataHazards'></a>Data Hazards

####  1.1. <a name='ArithemticHazard'></a>Arithemtic Hazard
- Hazard occur due to arithemtic operation(e.g. add, sub, etc...)
- Simply handle with data forwarding
    - Becuase, result can forward from EX/MEM register &rarr; no delay!

- Data forwarding conditions
    - EX/MEM to ID/EX
        - Check forwarding needed
            - EX/MEM.rd = ID/EX.rs1/rs2 &rarr; destination check
            - EX/MEM.RegWrite = 1 &rarr; only for regwriting opeartion
            - EX/MEM.RegisterRd != 0 &rarr; destination is not zero
    - MEM/WB to ID/EX
        - Same as forwarding but have recent is first(EX/MEM is prior than MEM/WB)

####  1.2. <a name='LoadHazard'></a>Load Hazard
- Hazard occur due to load operation(e.g. lw, lb, etc...)
- Unavoidable stall!
    - load operation's outcome can only forward at MEM/WB register -> &rarr; at least 1 cycle delay
    - So, data hazard next to load operation must handle with stalling

- Data forwarding conditions
    - due to stalling, have to check at ID/EX &harr; IF/ID
        - have to make signal at ID phase
        - ID/EX.rd = IF/ID.rs1/rs2
        - ID/EX.MemRead = 1 &rarr; only for reading memory operation

- Then What happen?
    - stall ID/EX, IF/ID
        - Send nop signal(0) to ID/EX
        - Stall PC update (PCWrite)
        - Keep IF/ID register (IF/IDWrite)

##  2. <a name='ControlHazards'></a>Control Hazards
- Reduce stall! : most important
    - make decision early : EX phase to ID phase
        - By checking equality of rs1, rs2
    - Advantage
        - reduce average stall 3 to 1;
    - Disadvantage
        - Data hazard problem;
            - Data frowarding is EX/MEM, MEM/WB to EX phase
            - but, beq operate at ID phase so, cannot handle with data forwarding
                - So, have to stall 1 cycle(RegWrite), 2 cycle(MemRead)

- Before decision : Prediction
    - Static Prediction
        - Always taken, Always not taken : average 50%
    
    - Dynamic Prediction
        - Record branch result(cache)
        - Caching each branch PC's result
            - recording address of instruction address, prediciton bits, Target address
            - Prediction bits
                - start at 0
                - if taken, add 1
                - else not taken, reduce 1
                - Single Bits
                - Double BIts
        - Working process
            - Before get PC, check BTB
            - if cache hit, check prediction bits
                - if prediction bits is valid, then get target address
                - else not take target address

##  3. <a name='Exceptions'></a>Exceptions
- Exception : Unpredictable data flow change

- Interrupt : Event from external I/O controller

- Handling exceptions
    - save address of instruction that error occur in SEPC
    - send cause of exception
        - SCAUSE : 
        - vector interrupt : save handler's address