Linux syscalls:

60 - exit
42 - exit code
ex: 
mov rdi, 42 // the first parameter to a syscall is passed bia rdi
mov rax, 60
syscall

---

write syscall

write(file_descriptor, memory_address, number_of_characters_to_write)

file descriptor = 1 stdout; 2 stderr
memory_address = location in memory where our text begins
number_of_characters_to_write = self-explanatory

ex:
# write(1, 1337000, 10);

So, writing 10 characters (null character included) starting at position 1337000

1st parameter -> rdi register
2nd parameter -> rsi register
3rd parameter -> rdx
