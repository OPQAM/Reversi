; Calculator (Division)
; Compile with: nasm -f elf 12_calculator_division.asm
; Link with: ld -m elf_i386 12_calculator_division.o -o calculator_division
; Run with: ./calculator_division

%include        'functions.asm'

SECTION .data
msg1        db      ' remainder '   ; message to output result

SECTION .text
global  _start

_start:

    xor     edx, edx    ; zeroing edx (upper half of dividend, see *)
    mov     eax, 90
    mov     ebx, 7
    div     ebx
    call    iprint      ; calling integer print function on quotient
    mov     eax, msg1   ; move message string to eax
    call    sprint      ; call string printing function
    mov     eax, edx    ; moving remainder into eax
    call    iprintLF

    call    quit

;* NOTE: Even though in this case edx is 0 and all will be fine, if we later on use this program with something else, if it's part of a bigger program, it might not be zero, and we'll risk segfaulting.
; As an example, try dividing 90 by 7 and have a priori 1 in edx
