SECTION .data
msg     db      'Hello World!', 0Ah      ; 0Ah => Line feed

SECTION .text
global  _start

_start:
; Writing Hello World
    mov     edx, 13                      ; bytes to write
    mov     ecx, msg
    mov     ebx, 0x01                    ; write to STDOUT
    mov     eax, 0x04                    ; SYS_WRITE (kernel opcode 4)
    int     0x80

; Clean exit (dirty status code, but it answers some questions)
    mov     eax, 0x01                    ; SYS_EXIT
    mov     ebx, 42                      ; exit status code
    int     0x80
