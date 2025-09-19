; Hello World program with an external file included
; Compile: nasm -f elf 04_helloworld-inc.asm
; Link: ld -m elf_i386 04_helloworld-inc.o -o hellworld-inc

%include        'functions.asm'

SECTION .data
msg1    db      'Hello, brave new world!', 0h        ; the null
msg2    db      'This is how we recycle in NASM', 0h ; terminating byte
                                                         
SECTION .text
global _start

_start:
    
    mov     eax, msg1
    call sprintLF         ; calling the (new) string printing function

    mov     eax, msg2
    call sprintLF

    call quit           ; calling the quit function

    ; NOTE: the second message is being called twice.
