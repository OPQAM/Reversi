fgetstest: fgetstest.o
	gcc fgetstest.o -o fgetstest -no-pie
fgetstest.o: fgetstest.asm
	nasm -f elf64 -g -F dwarf fgetstest.asm
