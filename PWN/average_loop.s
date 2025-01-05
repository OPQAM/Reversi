.intel_syntax noprefix
.global _start
_start:
        xor rax, rax   # zeroing rax for avg
        xor rbx, rbx   # Will work as divisor later
        mov rbx, rsi   # number of items placed in rbx
        test rsi, rsi #bitwise test, check if rsi is zero
        jz end    # no items, rax = 0, jump to end

loop_start:

        add rax, [rdi]
        add rdi, 8
        dec rsi   #decrement the value of rsi by one
        jnz loop_start # if not zero, keep up the loop

final_calc:
        xor rdx, rdx  # Zeroing rdx to perform division
        div rbx      # Div performed and stored in rax


end:

