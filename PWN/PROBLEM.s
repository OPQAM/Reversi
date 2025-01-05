.intel_syntax noprefix
.global _start
_start:
        cmp rdi, 3
        ja default_case
        
        lea rax, [rsi + rdi * 8]
        mov rax, [rax]
        jmp rax

default_case:
        jmp 0x40332c

