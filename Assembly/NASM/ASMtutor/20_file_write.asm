; Write
; Compile with: nasm -f elf 20_file_write.asm
; Link with: ld -m elf_i386 20_file_write.o -o write
; Run with: ./write

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0h
contents db 'Hello World!', 0h

SECTION .text
global  _start

_start:

    mov     ecx, 0777o      ; permissions
    mov     ebx, filename
    mov     eax, 8          ; SYS_CREATE
    int     80h

    mov     edx, 12         ; number of bytes to write
    mov     ecx, contents
    mov     ebx, eax        
    mov     eax, 4          ; SYS_WRITE (kernel opcode 4)
    int     80h

    call    quit
