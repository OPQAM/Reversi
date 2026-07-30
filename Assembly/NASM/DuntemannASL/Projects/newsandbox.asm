section .data
section .text

global _start

_start:
    mov rbp, rsp ;Save stack pointer for debugger
    nop

    mov rax, 60  ;sys_exit
    xor rdi,rdi  ;return code
    syscall

section .bss
