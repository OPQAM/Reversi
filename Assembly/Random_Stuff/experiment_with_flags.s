.intel_syntax noprefix
.global _start

_start:
    mov eax, 10
    mov ebx, 5

    cmp eax, ebx
    jg greater

    # We only get here if the jump is NOT taken
    mov eax, 60
    mov edi, 0
    syscall

greater:
    # We only get here if the jump IS taken
    mov eax, 60
    mov edi, 1
    syscall

    # The idea is just to use this as a boilerplate to experiment with changing flags
    # Ex: set $eflags |= (1 << 6)    -----> Setting ZF = 1
