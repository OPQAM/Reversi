; Namespace
; Compile with: nasm -f elf 14_namespace.asm
; Link with: ld -m elf_i386 14_namespace.o -o namespace
; Run with: ./namespace

%include        'functions.asm'

SECTION .data
msg1        db      'Jumping to finished label.', 0x00
msg2        db      'Inside subroutine number: ', 0x00
msg3        db      'Inside subroutine "finished".', 0x00

SECTION .text
global  _start

_start:

subroutineOne:
    mov     eax, msg1
    call    sprintLF
    jmp     .finished

.finished:
    mov     eax, msg2
    call    sprint
    mov     eax, 1
    call    iprintLF

subroutineTwo:
    mov     eax, msg1
    call    sprintLF
    jmp     .finished

.finished:
    mov     eax, msg2
    call    sprint
    mov     eax, 2
    call    iprintLF

    mov     eax, msg1
    call    sprintLF
    jmp     finished

finished:
    mov     eax, msg3
    call    sprintLF
    call    quit
