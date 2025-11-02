; Socket
; Compile with: nasm -f elf 28_sockets_listen.asm
; Link with: ld -m elf_i386 28_sockets_listen.o -o socket
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

    mov     edi, eax            ; bind socket from previous lesson
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

    push    byte 1              ; move 1 onto stack (max queue length argument)
    push    edi                 ; file descriptor
    mov     ecx, esp
    mov     ebx, 0x04           ; invoke subroutine LISTEN (4)
    mov     eax, 0x66           ; SYS_SOCKETCALL (kernel opcode 102)
    int     0x80

_exit:
    
    call    quit
