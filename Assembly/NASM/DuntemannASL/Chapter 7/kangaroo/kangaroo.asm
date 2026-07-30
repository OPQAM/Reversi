section .data
	Snippet	db "KANGAROO"

section .text
	global main

main:
    mov rbp,rsp ;Save stack pointer for debugger

    nop     
; Put your experiments between the two nops...

	mov rbx,Snippet
	mov rax,8
DoMore:	add byte [rbx],32
	inc rbx
	dec rax
	jnz DoMore     
	
; Put your experiments between the two nops...
	nop
