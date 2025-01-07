section .data
    msg db 'This is my first Assembly program.', 0xa   ;to be printed
    len equ $ - msg ; calculates the length of the string above

; db -> 'define byte'. It allocates storage for a string of bytes
; and initializes it with a given value
; 0xa -> newline character
; on len:  $ is the current address in the assembler.
; so len = $ - msg (difference between the current address and start of msg)

section .text
    global _start

_start:
    mov edx, len ; sys_write syscall expects the length of the data in edx
    mov ecx, msg ; sys_write expects the address of msg to be in ecx
    mov ebx, 1 ; 1 is the file descriptor of stdout
    mov eax, 4 ; 4 is the call number for sys_write
    int 0x80

    mov eax, 1
    int 0x80

; int 0x80 syscalls...
;
;SYS_WRITE
; eax: syscall number           (4 for sys_write)
; ebx: file descriptor          (1 for stdout)
; ecx: pointer to the buffer    (message string)
; edx: number of bytes to write (length of message)
;
;SYS_EXIT
; eax: specify syscall number   (1 for sys_exit)
; More info:
; https://syscalls32.paolostivanin.com/
