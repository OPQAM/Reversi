;  Executable name : showargs3
;  Version         : 3.0
;  Created date    : 10/1/1999
;  Last update     : 7/18/2023
;  Author          : Jeff Duntemann
;  Description     : A demo that shows how to access command line arguments
;                    stored on the stack by addressing them relative to rbp.
;
;  Build using these commands:
;    nasm -f elf64 -g -F dwarf showargs3.asm
;    gcc showargs3.o -o showargs3
;

[SECTION .data]    ; Section containing initialised data
		
ArgMsg db "Argument %d: %s",10,0

[SECTION .bss]     ; Section containing uninitialized data
	
[SECTION .text]    ; Section containing code
				
global main        ; Required so linker can find entry point
extern printf      ; Notify linker that we're calling printf

main:
    push rbp       ; Set up stack frame for debugger
    mov rbp,rsp

;;; Everything before this is boilerplate; use it for all ordinary apps!

    mov r14,rdi    ; Get arc count (argc) from RDI
    mov r13,rsi    ; Put the pointer to the arg table argv from RSI
    xor r12,r12    ; Clear r12 to 0

.showit:

    mov rdi,ArgMsg ; Pass address of display string in rdi
    mov rsi,r12    ; Pass argument number in rsi
    mov rdx,qword [r13+r12*8]   ; Pass address of an argument in RDX
    call printf    ; Display the argument # and argument

    inc r12        ; Bump argument # to next argument
    dec r14        ; Decrement argument counter by 1
    jnz .showit    ; If argument count is 0, we're done

;;; Everything after this is boilerplate; use it for all ordinary apps!

    mov rsp,rbp    ; Destroy stack frame before returning
    pop rbp

	ret            ; Return to glibc shutdown code
