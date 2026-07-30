section .data
        answermsg db    "The answer is %d ... or is it %d? No! It's 0x%x!",10,0
        answernum dd    42

section .bss

section .text

extern  printf

global  main

main:
    push rbp            ; Prolog
    mov rbp,rsp

    mov rax,0           ; Count of floating point args..here, 0

    mov rdi,answermsg   ; Message/format string goes in RDI
    mov rsi,[answernum] ; Second arg in RSI
    mov rdx,43          ; Third arg in RDX. You can use a numeric literal
    mov rcx,42          ; Fourth arg in RCX. Show this one in hex
    call printf         ; Call printf()

    mov rsp,rbp         ; Epilog
    pop rbp

    ret                 ; Return from main() to shutdown code
