eatmacro: eatmacro.o
	ld -o eatmacro eatmacro.o
eatmacro.o: eatmacro.asm
	nasm -f elf64 -l eatmacro.lst -g -F dwarf eatmacro.asm
