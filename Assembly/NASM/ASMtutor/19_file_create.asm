i; Create
; Compile with: nasm -f elf 19_file_create.asm
; Link with: ld -m elf_i386 19_file_create.o -o create
; Run with: ./create

%include        'functions.asm'

SECTION .data
filename db 'readme.txt', 0h    ; filename to create

SECTION .text
global  _start

_start:

    mov     ecx, 0777o      ; octal. Setting all permissions to read, write, execute
    mov     ebx, filename
    mov     eax, 8          ; invoke SYS_CREAT (kernel opcode 8)
    int     80h

    call    quit
