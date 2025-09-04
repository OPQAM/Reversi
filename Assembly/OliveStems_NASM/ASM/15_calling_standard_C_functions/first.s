; external functions to be linked later
extern printf
extern exit

; printf(format, message)

section .data
        msg DD "Hello World!",0 ;0 null terminates
        msg2 DD "This is a test!", 0
        fmt DB "Output is: %s %s",10,0 ;10 is newline
section .text
global main

main:        ; we need a main function to work with GCC
        PUSH msg2; take heed of the order. We're in the stack
        PUSH msg; push data onto stack
        PUSH fmt
        CALL printf
        PUSH 42 ; exit code
        CALL exit
