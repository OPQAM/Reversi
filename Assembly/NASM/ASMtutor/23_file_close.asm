; Close
; Compile with: nasm -f elf 23_file_close.asm
; Link with: ld -m elf_i386 23_file_close.o -o close
; Run with: ./close
 
%include    'functions.asm'
 
SECTION .data
filename db 'readme.txt', 0x00    ; the filename to create
contents db 'Hello world!', 0x00  ; the contents to write
 
SECTION .bss
fileContents resb 255,            ; variable to store file contents
 
SECTION .text
global  _start

_start:

    mov     ecx, 0777o          ; Create file from lesson 22
    mov     ebx, filename
    mov     eax, 0x08
    int     0x80

    mov     edx, 12             ; Write contents to file from lesson 23
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, 0x04
    int     0x80

    mov     ecx, 0              ; Open file from lesson 24
    mov     ebx, filename
    mov     eax, 0x05
    int     0x80

    mov     edx, 12             ; Read file from lesson 25
    mov     ecx, fileContents
    mov     ebx, eax
    mov     eax, 0x03
    int     0x80

    mov     eax, fileContents
    call    sprintLF

; next step is not needed. Used to show  that SYS_CLOSE takes file descriptor from EBX
    mov     ebx, ebx
    mov     ebx, 0x06           ; SYS_CLOSE (kernel opcode 6)
    int     0x80

    call    quit
