# Note on compiling these files

Since we're also depending on our own created function, we need to compile our ASM code with it. So we do:

.nasm -f elf -o first.o first.s
. gcc -no-pie -m32 first.o test.c -o first

So we're basically linking the two different scripts and compiling them into a single 'first' file.
