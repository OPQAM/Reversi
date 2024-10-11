section .data                                                                           
    num1 db '1', 0
    num2 db '2', 0
    newline db 0xa, 0    
    result db '0', 0

section .text
    global _start

_start:

    ; Printing 1
    mov eax, 4              
    mov ebx, 1              
    mov ecx, num1           
    mov edx, 1              
    int 0x80                
    
    ; newline
    mov ecx, newline
    int 0x80

    ; Printing 2
    mov ecx, num2 
    int 0x80      
    
    ; newline
    mov ecx, newline
    int 0x80    

    ; Adding 1 to 2
    mov eax, [num1]
    sub eax, '0'            
    mov ebx, [num2]
    sub ebx, '0'            
    add eax, ebx

    ; Convert to ASCII to print
    add eax, '0'
    mov [result], al        


    ; Printing the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result           
    mov edx, 1
    int 0x80

    ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    ; Exiting the program
    mov eax, 1              ; syscall number for sys_exit
    xor ebx, ebx            ; return 0 status
    int 0x80




; NOTES:
;
; ASCII CONVERSION LOGIC
; The ASCII value of '1' is 49
; The ASCII value of '0' is 48
; So, by making '1' - '0' we get 1.
;
; Offsetting by -48 always returns the
; int value.
;
; And, likewise, adding to an int +48
; returns us the ASCII corresponding
; value

; BRACKETS
; [num1] with the brackets means that we're referring to the
; value stored at memory location of num1 (not num1 itself)
; Why al? 'db' above allocates 1 byte of storage for each
; element

; RETURN STATUS
; Doing xor ebx, ebx is faster than doing, for example mov ebx, 0
; The former is a bitwise operation, the latter requires loading an
; immediate value to the instruction. Truly, nowadays, both are
; equally fast, due to optimizations

; ALWAYS SETTING REGISTERS
; in assembly programming, it's always safer to explicitly set the 
; registers for each syscall. Why?
; ---> Some syscalls might slightly modify register values(!)
; WHY: reusing registers is more efficient than saving and restoring
; So, the kernel often uses registers for its own computations
; There may also be context switches, with registries being modified
; ---> No ambiguity
; ---> Easier to debug.

