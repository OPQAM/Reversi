.intel_syntax noprefix
.global _start

.section .data
path: .asciz "/home/opqam/Projects/RE/PWN/asm_created_directory"  # null-terminated string

.section .text
_start:
	lea rdi, path
	mov rax, 39
	mov rsi, 0777  # permissions for folder
	syscall

	mov rax, 60
	xor rdi, rdi   # return code
	syscall


# NOT WORKING YET
