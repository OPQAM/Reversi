.intel_syntax noprefix
.global _start
_start:
	# Let's set a 5 second alarm
	mov rdi, 5
	mov rax, 37           # alarm syscall
	syscall

	# Waiting for the alarm signal
	mov rax, 34	      # pause syscall
	syscall

	# Exiting
	mov rdi, 66           # route 66 exit code
	mov rax, 60           # exit syscall
	syscall
