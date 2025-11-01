; Hello program, with string length calculation
; Compile with: nasm -f elf 02_calculate_string_length.asm
; Link with: ld -m elf_i386 02_calculate_string_length.o -o 02_calculate

SECTION .data
msg     db      'Hello darkness my old friend...', 0Ah

SECTION .text
global _start

_start:

    mov     ebx, msg        ; moving address of string into ebx
    mov     eax, ebx
    
nextchar:
    cmp     byte [eax], 0   ; compare byte pointed to by EAX against 0 (string delimiter)
    jz      finished        ; if = 0, jump to finished
    inc     eax             ; increment eax by 1
    jmp     nextchar        ; jump back to nextchar and repeat

finished:
    sub     eax, ebx        ; eax has been 'forced' to be as long as our message 
                            ; (+ original memory position). When we subtract ebx from it, 
                            ; we get the exact size in bytes of our msg (+ null character)

    mov     edx, eax        ; edx holds our count
    mov     ecx, msg
    mov     ebx, 0x01
    mov     eax, 0x04
    int     0x80

    mov     ebx, 0          ; We're behaving, so we return a nice value
    mov     eax, 0x01
    int     0x80
