timetest: timetest.o
	gcc timetest.o -o timetest -no-pie
timetest.o: timetest.asm
	nasm -f elf64 -g -F dwarf timetest.asm
