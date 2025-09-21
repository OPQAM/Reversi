; Hello <user> program - with user input
; Compile with: nasm -f elf 06_helloworld-input.asm
; Link with: ld -m elf_i386 06_helloworld-input.o -o helloworld-input
; Run with: ./helloworld-input

%include        'functions.asm'

SECTION .data
msg1        db      'Please enter your name: ', 0h
msg2        db      'Hello, ', 0h

SECTION .bss
sinput:     resb    255

SECTION .text
global _start

_start:

    mov     eax, msg1
    call    sprint

    mov     edx, 255        ; number of bytes to read
    mov     ecx, sinput     ; reserved space to store input (buffer)
    mov     ebx, 0          ; Read from the STDIN file
    mov     eax, 3          ; invoke SYS_REEAD (kernel opcode 3)
    int     80h

    mov     eax, msg2       ; move butter into eax
    call    sprint

    mov     eax, sinput    ; moving butter into eax
    call    sprint

    call    quit
