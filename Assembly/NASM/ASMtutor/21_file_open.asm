; Open
; Compile with: nasm -f elf 21_file_open.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 21_file_open.o -o open
; Run with: ./open

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0x00
contents db 'Hello World!', 0x00

SECTION .text
global  _start

_start:

    mov     ecx, 0777o
    mov     ebx, filename
    mov     eax, 0x08
    int     0x80

    mov     edx, 12
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, 0x04
    int     0x80

    mov     ecx, 0          ; flag for readonly access mode (O_RDONLY)
    mov     ebx, filename   
    mov     eax, 0x05       ; invoking SYS_OPEN (kernel opcode 5)
    int     0x80

    call    iprintLF
    call    quit
