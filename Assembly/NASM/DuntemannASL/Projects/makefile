ASM = nasm
ASMFLAGS = -f elf64 -g -F dwarf

.SECONDARY:

%.o: %.asm
	nasm $(ASMFLAGS) $< -l $*.lst

%: %.o
	ld -o $@ $<
