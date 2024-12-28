.intel_syntax noprefix
.global _start
_start:
        xor rax, rax              # clearing rax

        mov rax, [rsp]            # moving the value to rax
        add rax, [rsp + 8]        # adding the other quad words
        add rax, [rsp + 16]
        add rax, [rsp + 24]

        mov rcx, 4                # Preparing divisor
        xor rdx, rdx              # Clearing the upper dividend
        div rcx                   # Dividing

        push rax                  # Pushing result onto stack

# NOTE: we could have used hexadecimal values. example...
# add rax, [rsp + 0x10]
