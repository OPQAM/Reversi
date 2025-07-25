section .data
	num DD 5

section .text
global _start

_start:
	MOV eax,1
	MOV ebx,num
	INT 80h

; when we echo $? we're not getting the value 5 as expected.
; check why with gdb

; Long story short, we're placing inside ebx not the value of num but the data ddress of num
