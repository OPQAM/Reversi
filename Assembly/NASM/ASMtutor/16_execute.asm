; Execute
; Compile with: nasm -f elf 16_execute.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 16_execute.o -o execute
; Run with: ./execute

%include        'functions.asm'

SECTION .data
;command         db      '/bin/ls', 0x00     ; alternative command to be executed
;command         db      '/bin/sleep', 0x00  ; alternative command to be executed
command         db      '/bin/echo', 0x00    ; command to be executed



;arg1            db      '-l', 0h
;arg1            db      '5', 0h
arg1            db      'Hello World!', 0x00
arguments       dd      command
                dd      arg1                ; arguments to pass to the commandline
                dd      0x00                ; end of struct
environment     dd      0x00                ; args to pass as env variables; end struct

SECTION .text
global  _start

_start:
    mov     edx, environment    ; address of env variables
    mov     ecx, arguments      ; address of arguments to pass to the commandline
    mov     ebx, command        ; address of the file to execute
    mov     eax, 0x0b            ; invoking SYS_EXECVE (kernel opcode 11)
    int     80h

    call    quit
