randtest: randtest.o
	gcc randtest.o -o randtest -no-pie
randtest.o: randtest.asm
	nasm -f elf64 -F dwarf randtest.asm
