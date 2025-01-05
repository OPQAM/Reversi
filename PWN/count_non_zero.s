.intel_syntax noprefix
.global _start
_start:

        test rdi, rdi           # As asked by exercise: check if rdi = 0
        jz end

        xor rax, rax            # Good practice: zero out registers
        xor rbx, rbx            # Zero out index counter (rbx)

not_zero:
        mov rdx, [rdi + rbx]
        test rdx, rdx
        jz end
        add rbx, 1              # Advance counter
        jmp not_zero

end:
        mov rax, rbx            # Always load rax with counter value

