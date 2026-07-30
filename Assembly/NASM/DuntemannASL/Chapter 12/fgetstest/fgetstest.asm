;  Executable name : fgetstest
;  Version         : 3.0
;  Created date    : 11/19/2022
;  Last update     : 7/18/2022
;  Author          : Jeff Duntemann
;  Description     : Demonstrates calls made into libc, using NASM 2.14.02 
;                    to enter a short text string with gets() and display 
;                    with printf().
;
;                  : Build with this makefile, being midful of the required tabs:
;   fgetstest: fgetstest.o
;       gcc fgetstest.o -o fgetstest -no-pie
;   fgetstest.o: fgetstest.asm
;       nasm -f elf64 -g -F dwarf fgetstest.asm

SECTION .data           ; Section containing initialized data	

message: db "You just entered: %s."	
	
SECTION .bss            ; Section containing uninitialized data

testbuf: resb 20 
BUFLEN   equ $-testbuf

SECTION .text           ; Section containing code

extern printf
extern stdin	
extern fgets

global main             ; Required so the linker can find the entry point
	
main:
    push rbp             ; Set up stack frame for debugger
	mov rbp,rsp
    and rsp,-16
;;; Everything before this is boilerplate; use it for all ordinary apps!

; Get a number of characters from the user:		
    mov rdi,testbuf      ; Put address of buffer into RDI
    mov rsi,BUFLEN       ; Put # of chars to enter in RSI
    mov rdx,[stdin]
    call fgets           ; Call libc function for entering data

;Display the entered characters:
    mov rdi,message      ; Base string's address goes in RDI
    mov rsi,testbuf      ; Data entry buffer's address goes in RSI
    xor rax,rax          ; 0 in RAX tells printf no SSE registers are coming    
    call printf          ; Call libc function to display entered chars

;;; Everything after this is boilerplate; use it for all ordinary apps!
	mov rsp,rbp          ; Destroy stack frame before returning
    pop rbp

    ret                  ; Return to glibc shutdown code

