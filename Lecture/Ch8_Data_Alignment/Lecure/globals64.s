	.file	"globals.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	" %-8s: %4zu %8p\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a3,%hi(d)
	addi	sp,sp,-16
	ld	a1,%lo(d)(a3)
	sd	s0,0(sp)
	lui	s0,%hi(.LC0)
	addi	a3,a3,%lo(d)
	li	a2,8
	addi	a0,s0,%lo(.LC0)
	sd	ra,8(sp)
	call	printf
	lui	a3,%hi(f)
	flw	fa5,%lo(f)(a3)
	li	a2,4
	addi	a3,a3,%lo(f)
	fcvt.d.s	fa5,fa5
	addi	a0,s0,%lo(.LC0)
	fmv.x.d	a1,fa5
	call	printf
	lui	a3,%hi(p)
	ld	a1,%lo(p)(a3)
	li	a2,8
	addi	a3,a3,%lo(p)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a5,%hi(.LANCHOR0)
	addi	a4,a5,%lo(.LANCHOR0)
	ld	a2,0(a4)
	ld	a3,8(a4)
	addi	a5,a5,%lo(.LANCHOR0)
	li	a4,16
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(ll)
	ld	a1,%lo(ll)(a3)
	li	a2,8
	addi	a3,a3,%lo(ll)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(l)
	ld	a1,%lo(l)(a3)
	li	a2,8
	addi	a3,a3,%lo(l)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(c2)
	lbu	a1,%lo(c2)(a3)
	li	a2,1
	addi	a3,a3,%lo(c2)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(i)
	lw	a1,%lo(i)(a3)
	li	a2,4
	addi	a3,a3,%lo(i)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(s)
	lh	a1,%lo(s)(a3)
	li	a2,2
	addi	a3,a3,%lo(s)
	addi	a0,s0,%lo(.LC0)
	call	printf
	lui	a3,%hi(c1)
	lbu	a1,%lo(c1)(a3)
	addi	a0,s0,%lo(.LC0)
	addi	a3,a3,%lo(c1)
	li	a2,1
	call	printf
	ld	ra,8(sp)
	ld	s0,0(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.globl	c1
	.globl	s
	.globl	i
	.globl	c2
	.globl	l
	.globl	ll
	.globl	i128
	.globl	p
	.globl	f
	.globl	d
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	i128, @object
	.size	i128, 16
i128:
	.zero	16
	.section	.sbss,"aw",@nobits
	.align	3
	.type	c1, @object
	.size	c1, 1
c1:
	.zero	1
	.zero	1
	.type	s, @object
	.size	s, 2
s:
	.zero	2
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.type	c2, @object
	.size	c2, 1
c2:
	.zero	1
	.zero	7
	.type	l, @object
	.size	l, 8
l:
	.zero	8
	.type	ll, @object
	.size	ll, 8
ll:
	.zero	8
	.type	p, @object
	.size	p, 8
p:
	.zero	8
	.type	f, @object
	.size	f, 4
f:
	.zero	4
	.zero	4
	.type	d, @object
	.size	d, 8
d:
	.zero	8
	.ident	"GCC: (g2ee5e430018) 12.2.0"
