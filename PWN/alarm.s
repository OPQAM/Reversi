.intel_syntax noprefix
.global _start
_start:
	# Exiting
	mov rdi, 42           # answer to life death and everything  exit code
	mov rax, 60           # exit syscall
	syscall
