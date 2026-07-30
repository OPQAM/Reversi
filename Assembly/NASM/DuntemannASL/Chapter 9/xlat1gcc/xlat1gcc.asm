;  Executable name : xlat1gcc
;  Version         : 2.0
;  Created date    : 8/21/2022
;  Last update     : 7/17/2023
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, 
;                  : using NASM 2.15, demonstrating the XLAT 
;                  : instruction to translate characters using 
;                  : translation tables.
;
;  Run it either in SASM or using this command in the Linux terminal:
;
;     xlat1gcc < input file > output file
;
;       If an output file is not specified, output goes to stdout
;
;  Build using SASM's default build setup for x64
;  To test from a terminal, save out the executable to disk.

SECTION .data       ; Section containing initialised data
	
    StatMsg: db "Processing...",10
    StatLen: equ $-StatMsg
    DoneMsg: db "...done!",10
    DoneLen: equ $-DoneMsg
	
; The following translation table translates all lowercase characters
; to uppercase. It also translates all non-printable characters to 
; spaces, except for LF and HT. This is the table used by default in 
; this program.
    UpCase: 
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,7Bh,7Ch,7Dh,7Eh,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

; The following translation table is "stock" in that it translates all
; printable characters as themselves, and converts all non-printable
; characters to spaces except for LF and HT. You can modify this to
; translate anything you want to any character you want. To use it,
; replace the default table name (UpCase) with Custom in the code below.
    Custom: 
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
    db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
    db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
    db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
    db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
    db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
    db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

SECTION .bss            ; Section containing uninitialized data

    READLEN	    equ 1024        ; Length of buffer
    ReadBuffer: resb READLEN    ; Text buffer itself
	
SECTION .text           ; Section containing code

global  main

main:
    mov rbp,rsp      ; This keeps gdb happy...

; Display the "I'm working..." message via stderr:
    mov rax,1        ; Specify sys_write call
    mov rdi,2        ; Specify File Descriptor 2: Standard error
    mov rsi,StatMsg  ; Pass address of the message
    mov rdx,StatLen  ; Pass the length of the message
    syscall          ; Make kernel call

; Read a buffer full of text from stdin:
read:
    mov rax,0           ; Specify sys_read call
    mov rdi,0           ; Specify File Descriptor 0: Standard Input
    mov rsi,ReadBuffer  ; Pass address of the buffer to read to
    mov rdx,READLEN     ; Pass number of bytes to read at one pass
    syscall
    mov rbp,rax         ; Copy sys_read return value for safekeeping
    cmp rax,0           ; If rax=0, sys_read reached EOF
    je done             ; Jump If Equal (to 0, from compare)

; Set up the registers for the translate step:
    mov rbx,UpCase      ; Place the address of the table into rbx
    mov rdx,ReadBuffer  ; Place the address of the buffer into rdx
    mov rcx,rbp         ; Place number of bytes in the buffer into rcx
    
; Use the xlat instruction to translate the data in the buffer:
translate:
    xor rax,rax             ; Clear rax
    mov al,byte [rdx-1+rcx] ; Load character into AL for translation
    xlat                    ; Translate character in AL via table
    mov byte [rdx-1+rcx],al ; Put the xlated character back in buffer
    dec rcx                 ; Decrement character count
    jnz translate           ; If there are more chars in the buffer, repeat

; Write the buffer full of translated text to stdout:
write:
    mov rax,1           ; Specify sys_write call
    mov rdi,1           ; Specify File Descriptor 1: Standard output
    mov rsi,ReadBuffer  ; Pass address of the buffer
    mov rdx,rbp         ; Pass the # of bytes of data in the buffer
    syscall             ; Make kernel call
    jmp read            ; Loop back and load another buffer full

; Display the "I'm done" message via stderr:
done:	
    mov rax,1           ; Specify sys_write call
    mov rdi,2           ; Specify File Descriptor 2: Standard error
    mov rsi,DoneMsg     ; Pass address of the message
    mov rdx,DoneLen     ; Pass the length of the message
    syscall             ; Make kernel call

; All done! Let's end this party:
    ret                 ; Return to the glibc shutdown code

