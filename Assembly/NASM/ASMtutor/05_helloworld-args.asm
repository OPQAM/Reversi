; Program to Pass Arguments from the Command Line
; Compile with: nasm -f elf 05_helloworld-args.asm
; Link with (64 bit needs elf_i386): ld -m elf_i386 05_helloworld-args.o -o helloworld-args
; Run with: ./helloworld-args

%include        'functions.asm'

SECTION .text
global  _start

_start:

    pop     ecx         ; first stack value: number of arguments

nextArg:
    cmp     ecx, 0h     ; check if we have arguments left
    jz      noMoreArgs
    pop     eax         ; pop next element off the stack
    call    sprintLF    ; call print with linefeed function
    dec     ecx         ; decrease number of elements by 1
    jmp     nextArg

noMoreArgs:
    call    quit
