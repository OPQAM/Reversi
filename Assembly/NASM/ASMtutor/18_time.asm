; Time
; Compile with: nasm -f elf 18_time.asm
; Link with: ld -m elf_i386 18_time.o -o time
; Run with: ./time

%include        'functions.asm'

SECTION .data
msg         db      'Seconds since Jan 01 1970: ', 0x00

SECTION .text
global _start

_start:
    
    mov     eax, msg
    call    sprint      ; string printing

    mov     eax, 0x0d   ; SYS_TIME (kernel opcode 13)
    int     0x80

    call    iprintLF    ; integer printing with linefeed
    call    quit
