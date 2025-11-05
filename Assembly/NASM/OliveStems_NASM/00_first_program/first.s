section .data

section .text
global _start

_start:
	MOV eax,1            ; what system call we want to do (exit)
	MOV ebx,1	     ; status code 1
	INT 80h              ; a system interrupt (80h = exit with 1 in eax)
