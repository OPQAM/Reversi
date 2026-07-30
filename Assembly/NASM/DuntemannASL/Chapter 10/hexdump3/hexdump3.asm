;  Executable name : hexdump3
;  Version         : 2.0
;  Created date    : 9/14/2022
;  Last update     : 7/18/2023
;  Author          : Jeff Duntemann
;  Description     : A simple hex dump utility demonstrating the use of
;                  : separately assembled code libraries via EXTERN & GLOBAL
;
;  Build using these commands:
;    nasm -f elf64 -g -F dwarf hexdump3.asm
;    ld -o hexdump3 hexdump3.o <path>/textlib.o
;
SECTION .bss         ; Section containing uninitialized data

SECTION .data        ; Section containing initialised data
		
SECTION .text        ; Section containing code

EXTERN ClearLine, DumpChar, LoadBuff, PrintLine
EXTERN Buff, BuffLength

GLOBAL _start:

_start:
    push rbp
    mov rbp,rsp      ; For the benefit of gdb
;    nop              ; Ditto

; Whatever initialization needs doing before the loop scan starts is here:
    xor r15,r15
    xor rsi,rsi		
    xor rcx,rcx
    call LoadBuff    ; Read first buffer of data from stdin
    cmp r15,0        ; If r15=0, sys_read reached EOF on stdin
    jbe Exit

; Go through the buffer and convert binary values to hex digits:
Scan:
    xor rax,rax                ; Clear RAX to 0
    mov al,byte[Buff+rcx]      ; Get a char from the buffer into AL
    mov rdx,rsi                ; Copy total counter into RDX
    and rdx,000000000000000Fh  ; Mask out lowest 4 bits of char counter
    call DumpChar              ; Call the char poke procedure

; Bump the buffer pointer to the next character and see if buffer's done:
    inc rsi                    ; Increment buffer pointer
    inc rcx                    ; Increment total chars processed counter
    cmp rcx,r15                ; Compare with # of chars in buffer
    jb modTest                 ; If we've processed all chars in buffer...
    call LoadBuff              ; ...go fill the buffer again
    cmp r15,0                  ; If r15=0, sys_read reached EOF on stdin
    jbe Done                   ; If we get EOF, we're done

; See if we're at the end of a block of 16 and need to display a line:
modTest:
    test rsi,000000000000000Fh ; Test 4 lowest bits in counter for 0
    jnz Scan                   ; If counter is *not* modulo 16, loop back
    call PrintLine             ; ...otherwise print the line
    call ClearLine             ; Clear hex dump line to 0's
    jmp Scan                   ; Continue scanning the buffer

; All done! Let's end this party:
Done:
    call PrintLine             ; Print the "leftovers" line

Exit:	
    mov rax,60                 ; Code for Exit system call
    mov rdi,0                  ; Return a code of zero	
    syscall                    ; Make system call

