section .data
	num DD 5

section .text
global _start

_start:
	MOV eax,1
	MOV ebx,[num]  ; move the value stored IN the address into ebx (!)
	INT 80h
