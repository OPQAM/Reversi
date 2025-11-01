; Seek
; Compile with: nasm -f elf 24_file_seek.asm
; Link with: ld -m elf_i386 24_file_seek.o -o seek
; Run with: ./seek

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0x00
contents  db '-updated-', 0x00    ; contents to write at the start of the file

SECTION .text
global  _start

_start:

    mov     ecx, 1              ; writeonly acccess more flag (O_WRONLY)
    mov     ebx, filename
    mov     eax, 0x05           ; SYS_OPEN
    int     0x80

    mov     edx, 0              ; **SEEK_SET**
    mov     ecx, 6              ; **move the cursor 6 bytes**
    mov     ebx, eax            ; move opened file descriptor into EBX
    mov     eax, 0x13           ; SYS_LSEEK (kernel opcode 19)
    int     0x80

    mov     edx, 9              ; number of bytes to write
    mov     ecx, contents
    mov     ebx, ebx            
    mov     eax, 0x04
    int     0x80

    call    quit
