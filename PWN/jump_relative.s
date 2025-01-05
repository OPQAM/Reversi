.intel_syntax noprefix
.global _start
_start:
	jmp target             // Jump to the label 'target', which is 0x51 bytes from here
        .rept 0x51             // Repeat the next instruction 0x51 times (filling space between jump and target)
                nop           // No-op, fills the space to align the jump correctly
        .endr

target:
        mov rax, 0x1           // At the target location, set rax register to 0x1
