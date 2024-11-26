Linux syscalls:

60 - exit
42 - exit code
ex: 
mov rdi, 42 // the first parameter to a syscall is passed bia rdi
mov rax, 60
syscall

