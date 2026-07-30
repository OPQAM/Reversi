showargs2: showargs2.o
	ld -o showargs2 -g showargs2.o
showargs2.o: showargs2.asm
	nasm -f elf64 -g -F dwarf showargs2.asm -l showargs2.lst
