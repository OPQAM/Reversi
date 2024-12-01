.intel_syntax noprefix
.global _start

.data
    values:  .quad 0x1122334455667788   # Define a 64-bit value (big-endian hex)

.text
_start:
    mov rax, values           # Load the address of 'values' into rax
    mov rdi, word [rax+2]     # Dereference the address (plus an offset of 2) and load the 2-byte value into rdi

    # Exit syscall
    mov rax, 60               # Exit syscall number
    syscall

