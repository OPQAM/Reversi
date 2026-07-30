section .bss
	Buff resb 1

section .data

section .text
	global main

main:
    mov rbp, rsp   ; for correct debugging

Read:
    mov rax,0      ; Specify sys_read call
	mov rdi,0      ; Specify File Descriptor 0: Standard Input
	mov rsi,Buff   ; Pass address of the buffer to read to
	mov rdx,1      ; Tell sys_read to read one char from stdin
	syscall        ; Call sys_read

	cmp rax,0      ; Look at sys_read's return value in RAX
	je Exit        ; Jump If Equal to 0 (0 means EOF) to Exit:
			       ; or fall through to test for lowercase

	cmp byte [Buff],61h    ; Test input char against lowercase 'a'
	jb Write               ; If below 'a' in ASCII chart, not lowercase
	cmp byte [Buff],7Ah    ; Test input char against lowercase 'z'
	ja Write               ; If above 'z' in ASCII chart, not lowercase

                           ; At this point, we have a lowercase character
	sub byte [Buff],20h    ; Subtract 20h from lowercase to give uppercase...
                           ; ...and then write out the char to stdout
Write:  
    mov rax,1      ; Specify sys_write call
    mov rdi,1      ; Specify File Descriptor 1: Standard output
    mov rsi,Buff   ; Pass address of the character to write
    mov rdx,1      ; Pass number of chars to write
    syscall	       ; Call sys_write...
    jmp Read       ; ...then go to the beginning to get another character
        
Exit:   ret        

;Exit:
     mov rax,60    ; 60 = exit the program
;    mov rdi,0     ; Return value in rdi 0 = nothing to return
;    syscall       ; Call syscall to exit
