; Read
; Compile with: nasm -f elf 22_file_read.asm
; Link with: ld -m elf_i386 22_file_read.o -o read
; Run with: ./read

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0h
contents db 'Hellow World!', 0h

SECTION .bss
fileContents resb 255,          ; variable to store file contents

SECTION .text
global  _start

_start:

    mov     ecx, 0777o
    mov     ebx, filename
    mov     eax, 8
    int     80h

    mov     edx, 12
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, 4
    int     80h

    mov     ecx, 0
    mov     ebx, filename
    mov     eax, 5
    int     80h

    mov     edx, 12             ; number of bytes to read
    mov     ecx, fileContents   ; move the memory address of file contents var into ECX
    mov     ebx, eax            ; move opened file descriptor into EBX
    mov     eax, 3              ; SYS_READ (kernel opcode 3)
    int     80h

    mov     eax, fileContents   ; move memory address of file contents into EAX to print
    call    sprintLF
    
    call    quit
