;  Executable   : showargs2
;  Version      : 2.0
;  Created date : 11/3/2022
;  Last update  : 5/11/2023
;  Author       : Jeff Duntemann
;  Description  : A simple program in assembly for Linux, using NASM 2.15.05,
;                 demonstrating the way to access command line arguments on 
;                 the stack. This version accesses the stack "nondestructively"
;                 by using memory references calculated from RBP rather than
;                 POP instructions.
;
;    Use this makefile to build:
;    showargs2: showargs2.o
;        ld -o showargs2 -g showargs2.o
;    showargs2.o: showargs2.asm
;        nasm -f elf64 -g -F dwarf showargs2.asm -l showargs2.lst 
;

SECTION .data           ; Section containing initialized data

    ErrMsg db "Terminated with error.",10
    ERRLEN equ $-ErrMsg
	
SECTION .bss            ; Section containing uninitialized data	

; This program handles up to MAXARGS command-line arguments. Change the
; value of MAXARGS if you need to handle more arguments than the default 10.
; Argument lengths are stored in a table. Access arg lengths this way:
;     [ArgLens + <index reg>*8]
; Note that when the argument lengths are calculated, an EOL char (10h) is
; stored into each string where the terminating null was originally. This
; makes it easy to print out an argument using sys_write. 

    MAXARGS   equ  10       ; Maximum # of args we support
    ArgLens:  resq MAXARGS	; Table of argument lengths

SECTION .text       ; Section containing code

global  _start      ; Linker needs this to find the entry point!
	
_start:
    push rbp        ; Standard prolog
    mov rbp, rsp
    and rsp,-16    


; Copy the command line argument count from the stack and validate it:
    mov r13,[rbp+8]         ; Copy argument count from the stack
    cmp qword r13,MAXARGS   ; See if the arg count exceeds MAXARGS
    ja Error                ; If so, exit with an error message

; Here we calculate argument lengths and store lengths in table ArgLens:
    mov rbx,1               ; Stack address offset starts at RBX*8

ScanOne:
    xor rax,rax     ; Searching for 0, so clear AL to 0
    mov rcx,0000ffh ; Limit search to 65535 bytes max
    mov rdi,[rbp+8+rbx*8] ; Put address of string to search in RDI
    mov rdx,rdi     ; Copy starting address into RDX

    cld	            ; Set search direction to up-memory
    repne scasb     ; Search for null (binary 0) in string at RDI
    jnz Error       ; REPNE SCASB ended without finding AL

    mov byte [rdi-1],10	; Store an EOL where the null used to be
    sub rdi,rdx     ; Subtract position of 0 from start address
    mov [ArgLens+rbx*8],rdi    ; Put length of arg into table
    inc rbx         ; Add 1 to argument counter
    cmp rbx,r13     ; See if arg counter exceeds argument count
    jbe ScanOne     ; If not, loop back and scan another one

; Display all arguments to stdout:
    mov rbx,1 ; Start (for stack addressing reasons) at 1
Showem:
    mov rax,1       ; Specify sys_write call
    mov rdi,1       ; Specify File Descriptor 1: Standard Output
    mov rsi,[rbp+8+rbx*8]   ; Pass offset of the argument
    mov rdx,[ArgLens+rbx*8] ; Pass the length of the argument
    syscall         ; Make kernel call
    inc rbx         ; Increment the argument counter
    cmp rbx,r13     ; See if we've displayed all the arguments
    jbe Showem      ; If not, loop back and do another
    jmp Exit        ; We're done! Let's pack it in!

Error:
    mov rax,1       ; Specify sys_write call
    mov rdi,1       ; Specify File Descriptor 2: Standard Error
    mov rsi,ErrMsg  ; Pass offset of the error message
    mov rdx,ERRLEN  ; Pass the length of the message
    syscall         ; Make kernel call

Exit:
    mov rsp,rbp
    pop rbp
    
    mov rax,60      ; Code for Exit Syscall
    mov rdi,0       ; Return a code of zero	
    syscall         ; Make kernel call
