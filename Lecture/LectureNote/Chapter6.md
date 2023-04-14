RISC-V Assembly : Control Flow
==============================

Condition Statement
-------------------
### 1. if
- use single branch : when condition unmatched, to skip if statement block
	- example code
	```c
	if(a > b) a++;
	b++;
	```
	```asm
		ble		a0,a1,.L1	# a <= b ? goto .L2
		addi	a0,a0,1		# a++
	.L1:
		addi	a1,a1,1		# b++
	```
	- in this example, use ble to skip a++
	- note that in C code, we use bgt
### 2. if - else
- also use double branch : in else case, goto other and return to origin flow
	- example code
	```c
	if(a > b) a++;
	else b++:
	c++;
	```
	```asm
		ble		a0,a1,.L1	# a <= b ? goto .L2
		addi	a0,a0,1		# a++
	.L1:
		addi	a2,a2,1		# c++
		ret
	.L2:					# else block
		addi	a1,a1,1		# b++
		j		.L1
	```
	- in this code, in else case, goto .L2 and return to .L1 : to skip if block
	- if case, code flow directly connect with .L1 and return is locate between two block
	- other version
	```asm
		ble		a0,a1,.L1	# a <= b ? goto .L2
		addi	a0,a0,1		# a++
		j		.L2			# skip else block
	.L1:					# else block
		addi	a1,a1,1		# b++
	.L2:
		addi	a2,a2,1		# c++
		ret
	```
	- in this case, j is used in if block to skip else block
	- note that we can use ```beq x0,x0,.BLOCK``` as ```j```operation
### 3. if - else if - else
- we use (n+2) block for implement
	- n is # of else if block : but not necessity
	- example code
	```c
	if(a > b) a++;
    else if(b > c) b += 2;
    else c += 3;
	...

	return ~; 
	```
	```asm
	        ble     a0,a1,.L2               # check if
        	addi    a0,a0,1                 # 
	.L3:                                    # outside block
			ret                             # 
	.L2:                                    # else if block
			ble     a1,a2,.L4               # check esle if
			addi    a1,a1,2                 # 
			j       .L3                     # go outside
	.L4:                                    # else block
			addi    a2,a2,3                 # 
			j       .L3                     # go outside
	```

Loop Statement
--------------
- ***Note that*** all loop statement is basically implemneted by ***Do While*** statement in RISC-V Assembly
- Normally, single loop statement using 3 branch : one is while block, another is check condition block, last one is done block
### 1. Do while
- ***Note that*** initial condition check before first loop started
	- example code : guess A is int array
	```c
	do {
		i += 1;
	} while (A[i] == k)
	```
	```asm
	.Loop:
			addi	a0,a0,4			# get next address of A array(4-bytes due to integer)
	.Cond:
			ld		a2,0(a0)		# a0 is A[0]'s address
			neq		a2,a1,.Loop		# a1 is k, compare A[i] with k
	.Done:
			...
	```
### 2. While

### 3. For

CF - Intro/End part of function
---------------------------
- intro
```asm
foo:
        addi    sp,sp,-16       # set new stack frame consider return address
        sd      ra,8(sp)        # set return address to highest 8 byte(in 64-bit system) of stack frame
```
- end
```asm
.L3: #
        ld      ra, 8(sp)       # put back return address
		addi	sp,sp,16        # put back stack frame
        jr      ra              # return to return address
```