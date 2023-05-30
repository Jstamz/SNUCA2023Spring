CC=/opt/riscv/bin/riscv64-unknown-elf-gcc
ABI=lp64d
ARCH=rv64g
CFLAGS=-mabi=$(ABI) -march=$(ARCH) -O1 -S

TARGETS=$(patsubst %.c,%.asm,$(wildcard *.c))

.PHONY: clean

all: $(TARGETS)

%.asm: %.c
	$(CC) $(CFLAGS) -o .tmp $^
	cat $^ | awk '{ l++; printf "# %2d %s\n", l, $$0 }' > $@
	printf "\n\n" >> $@
	grep -vE "\.(option|attribute|type|size|ident)" .tmp | expand -t8 | awk '{printf("%-40s# \n",$$0)}' >> $@
	rm -f .tmp