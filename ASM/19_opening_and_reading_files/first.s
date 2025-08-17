section .data
        pathname DB "/home/opqam/Playground/Reversi/ASM/19_opening_and_reading_files/testfile.md"
section .bss
; reserving bytes for a buffer, in order to read the file
; How many characters do we want to read from the file?
        buffer resb 1024

section .text
global main

; We want to open a file, so we need sys_open.
; Therefore, we need to check it's requirements.
; Check table in readme.md

main:
        MOV eax,5 ; sys_open system call
        MOV ebx,pathname
        MOV ecx,0 ; flag for read only
        INT 80h

; eax will hold the file descriptor associated with our specific file
; we'll do a sys_read in order to check it out.
; To do that we'll need to move the descriptor to ebx as well

        MOV ebx,eax
        MOV eax,3
        MOV ecx,buffer
        MOV edx,1024 ; how much we want to read?
        INT 80h

        MOV eax,1
        MOV ebx,42
        INT 80h

section .note.GNU-stack noalloc noexec nowrite
