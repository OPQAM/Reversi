.intel_syntax noprefix
.global _start

.data
    # A pointer to a value
    pointer: .quad magic_number  # This stores the ADDRESS of magic_number
    magic_number: .quad 42       # The actual value

.text
_start:
    # Load the ADDRESS stored in 'pointer'
    mov rax, [pointer]   # rax now contains the memory address of magic_number
    mov rdi, rax         # Move this address to rdi as the exit code

    # Exit syscall
    mov rax, 60          # Exit syscall number
    syscall
