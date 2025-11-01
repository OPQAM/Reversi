; Write
; Compile with: nasm -f elf 20_file_write.asm
; Link with: ld -m elf_i386 20_file_write.o -o write
; Run with: ./write

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0x00
contents db 'Hello World!', 0x00

SECTION .text
global  _start

_start:

    mov     ecx, 0777o          ; permissions
    mov     ebx, filename
    mov     eax, 0x08           ; SYS_CREATE
    int     0x80

    mov     edx, 12             ; number of bytes to write
    mov     ecx, contents
    mov     ebx, eax        
    mov     eax, 0x04           ; SYS_WRITE (kernel opcode 4)
    int     0x80

    call    quit
