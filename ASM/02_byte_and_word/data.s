section .data
	num DB 1
	num2 DB 2

section .text
global _start

_start:
	MOV bl,[num]
	MOV ch,[num2]         ; Use gdb to check difference
	MOV eax,1
	INT 80h 


; Notice, for example:
;       0x0804900c in _start ()
;       (gdb) info registers ecx
;       ecx            0x200               512
;       (gdb) info registers cl
;       cl             0x0                 0
;       (gdb) info registers ch
;       ch             0x2                 2

; Basically 0010 0000 
