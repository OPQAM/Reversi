; Socket
; Compile with: nasm -f elf 26_sockets_create.asm
; Link with: ld -m elf_i386 26_socket_create.o -o socket
; Run with: ./socket
%include    'functions.asm'

SECTION .text
global  _start

_start:

    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi
    xor     esi, esi

_socket:

    push    byte 0x06   ; IPPROTO TCP
    push    byte 0x01   ; SOCK_STREAM
    push    byte 0x02   ; PF_INET
    mov     ecx, esp    ; move address of arguments into ecx
    mov     ebx, 0x01   ; invoke subroutine SOCKET (1)
    mov     eax, 0x66   ; invoke SYS_SOCKETCALL (kernel opecode 102)
    int     0x80

    call    iprintLF    ; (on error -1 will be printed)

_exit:

    call    quit
