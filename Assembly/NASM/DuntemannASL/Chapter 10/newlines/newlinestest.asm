;-------------------------------------------------------------------------
; Newlines:   Sends between 1-15 newlines to the Linux console
; VERSION:    2.0
; UPDATED:    7/19/2023
; IN:         EDX: # of newlines to send, from 1 to 15
; RETURNS:    Nothing
; MODIFIES:   Nothing. All caller registers preserved.
; CALLS:      Kernel sys_write
; DESCRIPTION: The number of newline chareacters (0Ah) specified in EDX
;              is sent to stdout using using INT 80h sys_write. This
;              procedure demonstrates placing constant data in the 
;              procedure definition itself, rather than in the .data or
;              .bss sections.

section .bss
section .data
section .text


newlines:
        
        cmp rdx,15   ; Make sure caller didn't ask for more than 15
        ja .exit     ; If so, exit without doing anything
        mov rsi,EOLs ; Put address of EOLs table into ECX
        mov rax,1    ; Specify sys_write
        mov rdi,1    ; Specify stdout
        syscall      ; Make the kernel call
.exit: 
        ret          ; Go home!
      
EOLs   db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10


global main

main:
        mov rbp,rsp
        nop
     
        mov rdx,7
        call newlines
 
        mov rax,60
        mov rdi,0
        syscall
