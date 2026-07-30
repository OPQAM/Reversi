answer: answer.o
	gcc answer.o -g -o answer -no-pie
answer.o: answer.asm
	nasm -f elf64 -g -F dwarf answer.asm -l answer.lst
