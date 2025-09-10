SECTION .data
msg     db      'Hello World!', 0Ah  ; 0Ah => Line feed

SECTION .text
global  _start

_start:
; Clean exit
    mov edx, 13                      ; bytes to write
    mov ecx, msg
    mov ebx, 1                       ; write to STDOUT
    mov eax, 4                       ; SYS_WRITE (kernel opcode 4)
    int 80h

; Clean exit (dirty status code, but it answers some questions)
    mov eax, 1                       ; SYS_EXIT
    mov ebx, 42                      ; exit status code
    int 80h
