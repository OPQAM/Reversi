textfile: textfile.o linlib.o
	gcc textfile.o linlib.o -o textfile -no-pie
textfile.o: textfile.asm
	nasm -f elf64 -g -F dwarf textfile.asm
linlib.o: linlib.asm
	nasm -f elf64 -g -F dwarf linlib.asm
