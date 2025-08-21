; --- constants ---
%define SYS_EXIT   1
%define SYS_WRITE  4
%define SYS_OPEN   5

%define O_WRONLY   01o
%define O_CREAT    0100o
%define O_TRUNC    01000o

; --- data section ---
section .data
        pathname DB "/home/opqam/Playground/Reversi/ASM/21_creating_and_writing_files/test.txt", 0 
        toWrite DB "Hello, World!",0AH
        toWriteLen equ $-toWrite ; NOTE*
 
 ; --- code section ---
section .text
global main

main:
        ; sys_open(path, O_WRONLY|O_CREAT, 0700)
        MOV eax, SYS_OPEN
        MOV ebx, pathname
        MOV ecx, O_WRONLY | O_CREAT | O_TRUNC
        MOV edx, 700o ; rwx------
        INT 0x80

        ; sys_write(fd, buf, len)
        MOV ebx, eax     ; fd from open
        MOV eax, SYS_WRITE
        MOV ecx, toWrite
        MOV edx, toWriteLen
        INT 0x80
       
        ; sys_exit(0)
        MOV eax, SYS_EXIT
        XOR ebx,ebx   ; will zero ebx
        INT 0x80

section .note.GNU-stack noalloc noexec nowrite

; NOTE: equ $-toWrite is an assembler trick, to compute the length of the string at assemble-time, so we don't have to hand-ount bytes. This sets that length dynamically, allowing for later changes.

; Also note that if we want to truncate the file when it already exists, then we could have done:
; MOV ecx, 01101o  ; O_WRONLY|O_CREAT|O_TRUNC

; Numeric values of O_... come directly from gibc's <fcntl.h>

; Yet another side-note: we can also create:
; %define O_WRONLY 01o (etc), and then use those 'names' in our code.
