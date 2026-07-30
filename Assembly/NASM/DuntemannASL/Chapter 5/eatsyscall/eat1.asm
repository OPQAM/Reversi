; %include "io64.inc"   ;Needed only for calls into libc

section .data
    eatmsg db "Eat at Joe's!", 0

section .text
    global main
    
main:
    mov rbp, rsp    ; Required for correct debugging via gdb
        
    mov rax,1       ; 1 = sys_write for syscall
    mov rdi,1       ; 1 = file descriptor for stdout; i.e., write to the terminal window
    mov rsi, eatmsg ; Put address of the message string in rsi
    mov rdx,13      ; Length of string to be written in rdx
    syscall         ; Make the system call

                    ; That done, we exit the program, again with a syscall:
    mov rax,60      ; 60 = exit
    mov rdi,0       ; Return value in rdi
    syscall         ; Call syscall to exit
