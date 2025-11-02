; Socket
; Compile with: nasm -f elf 30_sockets_read.asm
; Link with: ld -m elf_i386 30_sockets_read.o -o socket
; Run with: ./socket

%include        'functions.asm'

SECTION .bss
buffer resb 255,                ; variable to store request headers

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

    push    byte 1             
    push    edi                 
    mov     ecx, esp
    mov     ebx, 0x04           
    mov     eax, 0x66           
    int     0x80

_accept:

   push     byte 0              ; accept socket from previous lesson
   push     byte 0              
   push     edi                 
   mov      ecx, esp            
   mov      ebx, 0x05           
   mov      eax, 0x66           
   int      0x80

_fork:

    mov     esi, eax            ; move return value of SYS_SOCKETCALL into esi
    mov     eax, 0x02           ; SYS_FORK (kernel opcode 2)
    int     0x80

    cmp     eax, 0              ; SYS_FORK return value is 0 => child process
    jz      _read               ; jmp in child process to _read

    jmp     _accept             ; jmp in parent process to _accept

_read:

    mov     edx, 255            ; number of bytes to read
    mov     ecx, buffer         ; move momery address to buffer variable
    mov     ebx, esi            ; (accepted socket file descriptor)
    mov     eax, 0x03           ; SYS_READ (kernel opcode 3)
    int     0x80

    mov     eax, buffer         ; (for printing)
    call    sprintLF

_exit:
    
    call    quit
