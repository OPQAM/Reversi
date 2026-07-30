;  Executable name : eatsyscall
;  Version         : 1.0
;  Created date    : 4/25/2022
;  Last update     : 5/10/2023
;  Author          : Jeff Duntemann
;  Architecture    : x64
;  From            : x64 Assembly Language Step By Step, 4th Edition
;  Description     : A simple program in assembly for x64 Linux, using NASM 2.14,
;                    demonstrating the use of the syscall instruction to display text.
;                    Not for use with SASM.
;
;  Build using these commands:
;    nasm -f elf64 -g -F stabs eatsyscall.asm
;    ld -o eatsyscall eatsyscall.o
;

SECTION .data          ; Section containing initialised data
	
	EatMsg: db "Eat at Joe's!",10
 	EatLen: equ $-EatMsg	
	
SECTION .bss           ; Section containing uninitialized data	

SECTION .text          ; Section containing code

global 	_start	       ; Linker needs this to find the entry point!
	
_start:
    push rbp
    mov rbp,rsp

    mov rax,1           ; 1 = sys_write for syscall
    mov rdi,1           ; 1 = fd for stdout; i.e., write to the terminal window
    mov rsi,EatMsg      ; Put address of the message string in rsi
    mov rdx,EatLen      ; Length of string to be written in rdx
    syscall             ; Make the system call

    mov rax,60          ; 60 = exit the program
    mov rdi,0           ; Return value in rdi 0 = nothing to return
    syscall             ; Call syscall to exit














