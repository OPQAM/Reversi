.intel_syntax noprefix
.global _start
_start:

        jmp target      # jump into 0x51 from position
        .rept 0x51
                nop
        .endr

target:
        pop rdi         # pop top value into rdi
        mov rax, 0x403000
        jmp rax         # jumpt to absolute address

