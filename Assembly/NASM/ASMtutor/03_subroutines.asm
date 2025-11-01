; Hello World Program (Subroutines)
; Compile with: nasm -f elf subroutines.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 subroutines.o -o subroutines

SECTION .data
msg     db          'Hello pussycat, wow wooow woow!', 0Ah

SECTION .text
global  _start

_start:

    mov     eax, msg
    call    strlen          ; call function to calculate length of string

    mov     edx, eax        
    mov     ecx, msg        
    mov     ebx, 0x01
    mov     eax, 0x04
    int     0x80

    mov     ebx, 0x00
    mov     eax, 0x01
    int     0x80

strlen:
    push    ebx             ; push EBX onto the stack (preserve value during function call)
    mov     ebx, eax        ; move address in EAX into EBX

nextchar:                   ; same as in previous exercise
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar

finished:
    sub     eax, ebx
    pop     ebx             ; pop value on the stack back into EBX
    ret                     ; return to where the function was called
