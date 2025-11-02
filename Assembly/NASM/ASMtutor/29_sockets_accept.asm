; Socket
; Compile with: nasm -f elf 29_sockets_accept.asm
; Link with: ld -m elf_i386 29_sockets_accept.o -o socket
; Run with: ./socket

%include        'functions.asm'

SECTION .text
global  _start

_start:

    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi
    xor     esi, esi
   
_socket:
 
    push    byte 0x06           
    push    byte 0x01
    push    byte 0x02
    mov     ecx, esp
    mov     ebx, 0x01
    mov     eax, 0x66
    int     0x80

_bind:

    mov     edi, eax            
    push    dword 0x00000000
    push    word 0x2923
    push    word 2
    mov     ecx, esp
    push    byte 16
    push    ecx
    push    edi
    mov     ecx, esp
    mov     ebx, 0x02
    mov     eax, 0x66
    int     0x80

_listen:

    push    byte 1              ; listen socket from previous lesson
    push    edi                 
    mov     ecx, esp
    mov     ebx, 0x04           
    mov     eax, 0x66           
    int     0x80

_accept:

   push     byte 0              ; address length argument
   push     byte 0              ; adress argument
   push     edi                 ; file descriptor
   mov      ecx, esp            ; address of arguments onto ecx
   mov      ebx, 0x05           ; subroutine ACCPET (5)
   mov      eax, 0x66           ; SYS_SOCKETCAL (kernel opcode 102)
   int      0x80

_exit:
    
    call    quit
