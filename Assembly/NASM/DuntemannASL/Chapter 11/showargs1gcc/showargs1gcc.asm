;  Executable name : showargs1gcc
;  Version         : 2.0
;  Created date    : 10/17/2022
;  Last update     : 7/18/2023
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.14.02,
;                    demonstrating how to access command line arguments from
;                    programs written/built in SASM.
;
;                Build using SASM standard x64 build setup
;
SECTION .data                   ; Section containing initialised data

    ErrMsg db "Terminated with error.",10
    ERRLEN equ $-ErrMsg
        
    MAXARGS equ 5               ; More than 5 arguments triggers an error
	
SECTION .bss                    ; Section containing uninitialized data	

SECTION .text                   ; Section containing code

global 	main                    ; Linker needs this to find the entry point!
	
main:
    mov rbp, rsp            ; for correct SASM debugging
    nop                     ; This no-op keeps gdb happy...

    mov r14,rsi             ; Put offset of arg table in r14
    mov r15,rdi             ; Put argument count in r15

    cmp qword r15,MAXARGS   ; Test for too many arguments
    ja Error                ; Show error message if too many args & quit
              
; Use SCASB to find the 0 at the end of the single argument
    xor rbx,rbx             ; RBX contains the 0-based # (not address) of current arg 
Scan1:
    xor rax,rax             ; Searching for string-termination 0, so clear AL to 0
    mov rcx,0000ffffh       ; Limit search to 65535 bytes max
    mov rdi,qword [r14+rbx*8] ; Put address of string to search in RDI, for SCASB     
    mov rdx,rdi             ; Copy string address into RDX for subtraction
                                                                                                                                                                                                                                                                                                                    
    cld                     ; Set search direction to up-memory
    repne scasb             ; Search for null (0) in string at RDI
    jnz Error               ; Jump to error message display if null not found.

    mov byte [rdi-1],10     ; Store an EOL where the null used to be
    sub rdi,rdx             ; Subtract position of 0 in RDI from start address in RDX
    mov r13,rdi             ; Put calculated arg length into R13

; Display the argument to stdout:
    mov rax,1               ; Specify sys_write call
    mov rdi,1               ; Specify File Descriptor 1: Standard Output
    mov rsi,rdx             ; Pass offset of the arg in RSI
    mov rdx,r13             ; Pass length of arg in RDX
    syscall                 ; Make kernel call

    inc rbx                 ; Increment the argument counter
    cmp rbx,r15             ; See if we've displayed all the arguments
    jb Scan1                ; If not, loop back and do another
    jmp Exit                ; We're done! Let's pack it in!

Error:
    mov rax,1               ; Specify sys_write call
    mov rdi,1               ; Specify File Descriptor 2: Standard Error
    mov rsi,ErrMsg          ; Pass offset of the error message
    mov rdx,ERRLEN          ; Pass the length of the message
    syscall                 ; Make kernel call

Exit:
    ret

