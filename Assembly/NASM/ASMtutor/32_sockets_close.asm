; Socket
; Compile with: nasm -f elf 32_sockets_close.asm
; Link with: ld -m elf_i386 32_sockets_close.o -o socket
; Run with: ./socket

%include        'functions.asm'

SECTION .data
; response string
response db 'HTTP/1.1 200 OK', 0x0d, 0x0a, 'Content-Type: text/html', 0x0d, 0x0a, 'Content-Length: 14', 0x0d, 0x0a, 0x0d, 0x0a, 'Hello World!', 0x0d, 0x0a, 0x00

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

   push     byte 0              
   push     byte 0              
   push     edi                 
   mov      ecx, esp            
   mov      ebx, 0x05           
   mov      eax, 0x66           
   int      0x80

_fork:

    mov     esi, eax            ; fork socket from previous lesson
    mov     eax, 0x02           
    int     0x80

    cmp     eax, 0              
    jz      _read               

    jmp     _accept             

_read:

    mov     edx, 255            ; read socket from previous lessond
    mov     ecx, buffer         
    mov     ebx, esi            
    mov     eax, 0x03           
    int     0x80

    mov     eax, buffer         
    call    sprintLF

_write:
    
    mov     edx, 78             ; write socket from previous lesson
    mov     ecx, response       
    mov     ebx, esi            
    mov     eax, 0x04           
    int     0x80

_close:

    mov     ebx, esi            ; (accepted socket file descriptor)
    mov     eax, 0x06           ; SYS_CLOSE (kernel opcode 6)
    int     0x80

_exit:
    
    call    quit
