;  Executable name  : hexdump3gcc
;  Version          : 2.0
;  Created date     : 9/5/2022
;  Last update      : 5/9/2023
;  Author           : Jeff Duntemann
;  Description      : A simple hex dump utility demonstrating the use of
;                   : code libraries by inclusion via %INCLUDE
;
;  Build using SASM's standard x64 build setup
;
;  Type or paste some text into Input window and click Build & Run.
;

SECTION .bss        ; Section containing uninitialized data

SECTION .data       ; Section containing initialised data		
	
SECTION .text       ; Containing code
   
%INCLUDE "textlibgcc.asm"

GLOBAL main   ; You need to declare "main" here because SASM uses gcc
              ; to do builds.

;-------------------------------------------------------------------------
; MAIN PROGRAM BEGINS HERE
;-------------------------------------------------------------------------

main:
    mov rbp, rsp; for correct debugging

; Whatever initialization needs doing before loop scan starts is here:
    xor r15,r15     ; Zero out r15,rsi, and rcx
    xor rsi,rsi		
    xor rcx,rcx
    call LoadBuff   ; Read first buffer of data from stdin
    cmp r15,0       ; If r15=0, sys_read reached EOF on stdin
    jbe Exit

; Go through the buffer and convert binary byte values to hex digits:
Scan:
    xor rax,rax                ; Clear RAX to 0
    mov al,byte[Buff+rcx]      ; Get a byte from the buffer into AL
    mov rdx,rsi	               ; Copy total counter into RDX
    and rdx,000000000000000Fh  ; Mask out lowest 4 bits of char counter
    call DumpChar              ; Call the char poke procedure

; Bump the buffer pointer to the next character and see if buffer's done:
    inc rsi           ; Increment total chars processed counter
    inc rcx           ; Increment buffer pointer
    cmp rcx,r15       ; Compare with # of chars in buffer
    jb .modTest        ; If we've processed all chars in buffer...
    call LoadBuff     ; ...go fill the buffer again
    cmp r15,0         ; If r15=0, sys_read reached EOF on stdin
    jbe Done          ; If we get EOF, we're done

; See if we're at the end of a block of 16 and need to display a line:
.modTest:
    test rsi,000000000000000Fh ; Test 4 lowest bits in counter for 0
    jnz Scan                   ; If counter is *not* modulo 16, loop back
    call PrintLine             ; ...otherwise print the line
    call ClearLine             ; Clear hex dump line to 0's
    jmp Scan                   ; Continue scanning the buffer

; All done! Let's end this party:
Done:
    call PrintLine   ; Print the final "leftovers" line

Exit:	
    ret              ; Return to glibc's shutdown code


