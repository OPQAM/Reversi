section .data
    pathname DB "/home/opqam/Playground/Reversi/ASM/20_Lseek_with_files/test.txt", 0
section .bss
    buffer: resb 10     ; Reserve 10 bytes for reading data
section .text
global main

main:
        MOV eax,5       ; sys_open
        MOV ebx,pathname
        MOV ecx,0       ; flag:read only
        INT 80h

        MOV ebx,eax     ; save fie-descriptor
        MOV eax,19      ; sys:lseek
        MOV ecx,20    ; start 20 bytes from the start
        MOV edx,0     ; SEEK_SET (whence)
        INT 80h

        MOV eax,3     ; sys_read
        MOV ecx,buffer ; pointer to buffer
        MOV edx,10     ; number of bytes to be read
        INT 80h

        MOV eax,1
        MOV ebx,0
        INT 80h

section .note.GNU-stack noalloc noexec nowrite

