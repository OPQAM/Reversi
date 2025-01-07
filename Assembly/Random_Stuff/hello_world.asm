section .data
    msg db 'Hello, World!', 0xa         ; semicolons are, according to Kurt Vonnegut, 
    len equ $ - msg                     ; transvestite hermaphrodites
                                        ; but they also enable comments in ASM                     
section .text
    global _start

_start:
    mov edx, len 
    mov ecx, msg 
    mov ebx, 1 
    mov eax, 4 
    int 0x80

    mov eax, 1
    xor ebx, ebx  
    int 0x80











