eatlibc: eatlibc.o
	gcc eatlibc.o -o eatlibc -no-pie
eatlibc.o: eatlibc.asm
	nasm -f elf64 -g -F dwarf eatlibc.asm
