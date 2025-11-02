; Crawler
; Compile with: nasm -f elf 33_webpage_download.asm
; Link with: ld -m elf_i386 33_webpage_download.o -o crawler
; Run with: ./crawler

%include        'functions.asm'

SECTION .data
; request string
request db 'GET / HTTP/1.1', 0x0d, 0x0a, 'Host: 139.162.39.66:80', 0x0d, 0x0a, 0x0d, 0x0a, 0x00

SECTION .bss
buffer resb 1               ; variable to store response

SECTION .text
global  _start

_start:

    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi

_socket:

    push    byte 0x06       ; IPPROTO_TCP
    push    byte 0x01       ; SOCK_STREAM
    push    byte 0x02       ; PF_INET
    mov     ecx, esp
    mov     ebx, 0x01       ; invoke subroutine SOCKET (1)
    mov     eax, 0x66       ; SYS_SOCKETCALL (kernel opcode 102)
    int     0x80

_connect:

    mov     edi, eax
