;  Executable name : eatlibc
;  Version         : 3.0
;  Created date    : 11/12/2022
;  Last update     : 5/13/2023
;  Author          : Jeff Duntemann
;  Description     : Demonstrates calls made into libc, using NASM 2.14.02 
;                    to send a short text string to stdout with puts().
;
;  Build using these commands:
;    nasm -f elf64 -g -F dwarf eatlibc.asm
;    gcc eatlibc.o -o eatlibc


SECTION .data           ; Section containing initialised data
	
EatMsg: db "Eat at Joe's!",0	
	
SECTION .bss            ; Section containing uninitialized data

SECTION .text           ; Section containing code
	
extern puts             ; The simple "put string" routine from libc
global main             ; Required so the linker can find the entry point
	
main:
    push rbp            ; Set up stack frame for debugger
	mov rbp,rsp
;;; Everything before this is boilerplate; use it for all ordinary apps!
		
    mov rdi,EatMsg      ; Put address of string into rdi	
    call puts           ; Call libc function for displaying strings
    xor rax,rax         ; Pass a 0 as the program's return value.

;;; Everything after this is boilerplate; use it for all ordinary apps!
	mov rsp,rbp	        ; Destroy stack frame before returning
    pop rbp

    mov rax,60
    mov rdi,0
    syscall             ; Return control to Linux

