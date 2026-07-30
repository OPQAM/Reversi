charsin: charsin.o
	gcc charsin.o -o charsin -no-pie
charsin.o: charsin.asm
	nasm -f elf64 -g -F dwarf charsin.asm
