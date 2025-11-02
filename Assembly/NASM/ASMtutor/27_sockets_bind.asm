; Socket
; Compile with: nasm -f elf 27_sockets_bind.asm
; Link with: ld -m elf_i386 27_socket_bind.o -o socket
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

    push    byte 0x06   ; protocol = IPPROTO TCP
    push    byte 0x01   ; type = SOCK_STREAM
    push    byte 0x02   ; domain = PF_INET
    mov     ecx, esp    ; ecx points to [AF_INET, SOCK_STREAM, IPPOTO_TCP]
    mov     ebx, 0x01   ; subfunction 1 = SYS_SOCKET
    mov     eax, 0x66   ; syscall 102 = SYS_SOCKETCALL (kernel opecode 102)
    int     0x80

_bind:

    mov     edi, eax          ; move return value of SYS_SOCKETCALL into edi
    push    dword 0x00000000  ; IP ADDRESS (0.0.0.0)
    push    word 0x2923       ; push 9001 onto stack PORT (reverse byte order) our port
    push    word 2            ; push 2 dec onto stack AFINET
    mov     ecx, esp
    push    byte 16           ; (argument length)
    push    ecx
    push    edi
    mov     ecx, esp          ; ecx point sto [sockfd, sockaddr, addrlen]
    mov     ebx, 0x02         ; subfunction 2 = SYS_BIND
    mov     eax, 0x66         ; SYS_SOCKETCALL
    int     0x80


_exit:

    call    quit
