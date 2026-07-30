
;  Executable name : charsin
;  Version         : 3.0
;  Created date    : 11/19/2022
;  Last update     : 11/20/2022
;  Author          : Jeff Duntemann
;  Description     : A character input demo for Linux, using NASM 2.14.02,
;                  : incorporating calls to both fgets() and scanf().
;
;  Build using these commands:
;    nasm -f elf64 -g -F dwarf charsin.asm
;    gcc charsin.o -o charsin -no-pie
;	

[SECTION .data]         ; Section containing initialised data
	
SPrompt  db 'Enter string data, followed by Enter: ',0		
IPrompt  db 'Enter an integer value, followed by Enter: ',0
IFormat  db '%d',0
SShow    db 'The string you entered was: %s',10,0
IShow    db 'The integer value you entered was: %5d',10,0
	
[SECTION .bss]          ; Section containing uninitialized data

IntVal   resq 1         ; Reserve an uninitialized double word
InString resb 128       ; Reserve 128 bytes for string entry buffer
		
[SECTION .text]         ; Section containing code

extern stdin            ; Standard file variable for input
extern fgets
extern printf	
extern scanf		

global main             ; Required so linker can find entry point
	
main:
    push rbp            ; Set up stack frame
    mov rbp,rsp

;;; Everything before this is boilerplate; use it for all ordinary apps!

; First, an example of safely limited string input using fgets:
    mov rdi,SPrompt	    ; Load address of the prompt string into RDI
    call printf         ; Display it

    mov rdi,InString    ; Copy address of buffer for entered chars
    mov rsi,72          ; Accept no more than 72 chars from keybd
    mov rdx,[stdin]     ; Load file handle for standard input into RDX
    call fgets          ; Call fgets to allow user to enter chars

    mov rdi,SShow       ; Copy address of the string prompt into RSI
    mov rsi,InString    ; Copy address of entered string data into RDI
    call printf         ; Display it

; Next, use scanf() to enter numeric data:
    mov rdi,IPrompt     ; Copy address of integer input prompt into RDI
    call printf         ; Display it

    mov rdi,IFormat     ; Copy address of the integer format string into RDI
    mov rsi,IntVal      ; Copy address of the integer buffer into RSI
    call scanf          ; Call scanf to enter numeric data

    mov rdi,IShow       ; Copy address of base string into RDI
    mov rsi,[IntVal]    ; Copy the integer value to display into RSI
    call printf         ; Call printf to convert & display the integer

;;; Everything after this is boilerplate; use it for all ordinary apps!

    mov rsp,rbp         ; Destroy stack frame before returning
    pop rbp
	
    ret                 ; Return control to Linux

