; Crawler
; Compile with: nasm -f elf 33_webpage_download.asm
; Link with: ld -m elf_i386 33_webpage_download.o -o crawler
; Run with: ./crawler

%include        'functions.asm'

SECTION .data
; request string
request db 'GET / HTTP/1.1', 0x0d, 0x0a, 'Host: 139.162.39.66:80', 0x0d, 0x0a, 0x0d, 0x0a, 0x00

SECTION .bss
buffer resb 1                   ; variable to store response

SECTION .text
global  _start

_start:

    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi

_socket:

    push    byte 0x06           ; IPPROTO_TCP
    push    byte 0x01           ; SOCK_STREAM
    push    byte 0x02           ; PF_INET
    mov     ecx, esp
    mov     ebx, 0x01           ; invoke subroutine SOCKET (1)
    mov     eax, 0x66           ; SYS_SOCKETCALL (kernel opcode 102)
    int     0x80

_connect:

    mov     edi, eax            ; move return value of SYS_SOCKETCALL into edi
    push    dword 0x4227a28b    ; push 139.162.39.66 onto stack
    push    word 0x5000         ; push 80 onto stack PORT
    push    word 2              ; push 2 dec onto stack AF_INET    
    mov     ecx, esp
    push    byte 16             ; arguments length
    push    ecx
    push    edi
    mov     ecx, esp
    mov     ebx, 0x03           ; invoke subroutine CONNECT (3)
    mov     eax, 0x66           ; SYS_SOCKETCALL (kernel opcode 102)
    int     0x80

_write:

    mov     edx, 43             ; length in bytes to write
    mov     ecx, request        ; move address of request variable into ecx
    mov     ebx, edi
    mov     eax, 0x04           ; SYS_WRITE (kernel opcode 4)
    int     0x80

_read:

    mov     edx, 1              ; bytes to read (one at a time)
    mov     ecx, buffer
    mov     ebx, edi
    mov     eax, 3
    int     0x80

    cmp     eax, 0              ; if SYSREAD=0 we have reached end of file
    jz      _close

    mov     eax, buffer
    call    sprint
    jmp     _read

_close:

    mov     ebx, edi
    mov     eax, 0x06           ; SYS_CLOSE (kernel opcode 6)
    int     0x80

_exit:

    call    quit
