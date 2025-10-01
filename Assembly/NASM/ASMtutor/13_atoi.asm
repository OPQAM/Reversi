; Calculator (ATOI)
; Compile with: nasm -f elf 13_atoi.asm
; Link with: ld -m elf_i386 atoi.o -o calculator-atoi
; Run with: ./calculator-atoi 20 1000 317

%include        'functions.asm'

SECTION .text
global  _start

_start:

    pop     ecx         ; number of arguments
    pop     edx         ; program name - second stack value
    sub     ecx, 1      ; decrease ecx by 1
    mov     edx, 0      ; initialize data register to store additions

nextArg:
    cmp     ecx, 0h     ; check if arguments left
    jz      noMoreArgs  ; if zero is set
    pop     eax         ; pop next argument off the stack
    call    atoi        
    add     edx, eax    ; perform addition logic
    dec     ecx         ; decrease ecx by 1
    jmp     nextArg     

noMoreArgs:
    mov     eax, edx    ; move data to eax to print
    call    iprintLF
    call    quit
