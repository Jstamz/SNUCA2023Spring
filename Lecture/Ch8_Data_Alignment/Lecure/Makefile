SPIKE=/opt/riscv/build/spike
CC=/opt/riscv/bin/riscv64-unknown-elf-gcc
ABI=lp64d
ARCH=rv64g
CFLAGS= -Wall -O2 -fno-common -mabi=$(ABI) -march=$(ARCH) -o


all:
	$(CC) $(CFLAGS) globals64.s -S globals.c
	$(CC) $(CFLAGS) globals64.o -c globals64.s
	$(CC) $(CFLAGS) globals64 globals64.o

spike:
	$(SPIKE) pk globals64