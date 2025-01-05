.intel_syntax noprefix
.global _start
_start:
        cmp rdi, 3
        jg default_case         # jump if greater

        jmp [rsi + rdi * 0x8]

default_case:
        jmp [rsi + 0x20]

