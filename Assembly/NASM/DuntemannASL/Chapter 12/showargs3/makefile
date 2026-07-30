showargs3: showargs3.o
	gcc showargs3.o -o showargs3 -no-pie
showargs3.o: showargs3.asm
	nasm -f elf64 -g -F dwarf showargs3.asm
