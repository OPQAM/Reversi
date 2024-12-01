.intel_syntax noprefix
.global _start

_start:

	mov rdi, 5      # time to send SIGALRM to the process
	mov rax, 37     # alarm syscall
	syscall

	mov rax, 34     # pause syscall
	syscall

	mov rdi, 42     # our exit code
	
	mov rax, 60     # exit syscall
	syscall

