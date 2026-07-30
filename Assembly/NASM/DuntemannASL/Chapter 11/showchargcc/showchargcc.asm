;  Executable name : showchargcc
;  Version         : 2.0
;  Created date    : 10/19/2022
;  Last update     : 7/15/2023
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, 
;    demonstrating discontinuous string writes to memory using STOSB without
;    REP. The program loops through characters 32 through 255 and writes a
;    simple "ASCII chart" in a display buffer. The chart consists of 8 lines
;    of 32 characters, with the lines not continuous in memory.
;
;  Build using the standard SASM x64 build lines
;

SECTION .data       ; Section containing initialized data
    EOL 	equ 10  ; Linux end-of-line character
    FILLCHR	equ 32  ; Default to ASCII space character
    CHRTROW	equ 2   ; Chart begins 2 lines from top
    CHRTLEN	equ 32  ; Each chart line shows 32 chars

; This escape sequence will clear the console terminal and place the
; text cursor to the origin (1,1) on virtually all Linux consoles:
    ClrHome db 27,"[2J",27,"[01;01H"
    CLRLEN  equ $-ClrHome    ; Length of term clear string
    EOL     equ 10           ; Linux end-of-line character

	
; We use this to display a ruler across the screen. 
    RulerString db "12345678901234567890123456789012345678901234567890123456789012345678901234567890" 
    RULERLEN    equ $-RulerString
	
SECTION .bss                ; Section containing uninitialized data	

    COLS	equ 81          ; Line length + 1 char for EOL
    ROWS	equ 25          ; Number of lines in display
    VidBuff	resb COLS*ROWS  ; Buffer size adapts to ROWS & COLS

SECTION .text               ; Section containing code

global   main                ; Linker needs this to find the entry point!

ClearTerminal:
    push r11            ; Save all modified registers
    push rax
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax,1           ; Specify sys_write call
    mov rdi,1           ; Specify File Descriptor 1: Standard Output
    mov rsi,ClrHome     ; Pass address of the escape sequence
    mov rdx,CLRLEN      ; Pass the length of the escape sequence
    syscall	            ; Make system call

    pop rdi             ; Restore all modified registers
    pop rsi
    pop rdx
    pop rcx
    pop rax
    pop r11
    ret

;-------------------------------------------------------------------------
; Show:         Display a text buffer to the Linux console
; UPDATED:      5/10/2023
; IN:           Nothing
; RETURNS:      Nothing
; MODIFIES:     Nothing
; CALLS:        Linux sys_write
; DESCRIPTION:  Sends the buffer VidBuff to the Linux console via sys_write.
;               The number of bytes sent to the console is calculated by
;               multiplying the COLS equate by the ROWS equate.

Show:	
    push r11            ; Save all registers we're going to change
    push rax
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax,1           ; Specify sys_write call
    mov rdi,1           ; Specify File Descriptor 1: Standard Output
    mov rsi,VidBuff     ; Pass address of the buffer
    mov rdx,COLS*ROWS   ; Pass the length of the buffer
    syscall             ; Make system call

    pop rdi             ; Restore all modified registers
    pop rsi
    pop rdx
    pop rcx
    pop rax
    pop r11
    ret

;-------------------------------------------------------------------------
; ClrVid:       Clears a buffer to spaces and replaces overwritten EOLs
; UPDATED:      5/10/2023
; IN:           Nothing
; RETURNS:      Nothing
; MODIFIES:     VidBuff, DF
; CALLS:        Nothing
; DESCRIPTION:  Fills the buffer VidBuff with a predefined character
;               (FILLCHR) and then places an EOL character at the end
;               of every line, where a line ends every COLS bytes in
;               VidBuff.

ClrVid:	push rax        ; Save registers that we change
	push rcx
	push rdi
	cld                 ; Clear DF; we're counting up-memory
	mov al,FILLCHR      ; Put the buffer filler char in AL
	mov rdi,VidBuff     ; Point destination index at buffer
	mov rcx,COLS*ROWS   ; Put count of chars stored into RCX
	rep stosb           ; Blast byte-length chars at the buffer

; Buffer is cleared; now we need to re-insert the EOL char after each line:
	mov rdi,VidBuff     ; Point destination at buffer again
	dec rdi             ; Start EOL position count at VidBuff char 0
	mov rcx,ROWS        ; Put number of rows in count register

.PtEOL:	add rdi,COLS    ; Add column count to RDI
	mov byte [rdi],EOL  ; Store EOL char at end of row
	loop .PtEOL         ; Loop back if still more lines
	pop rdi             ; Restore caller's registers
	pop rcx
	pop rax
	ret                 ; and go home!

;-------------------------------------------------------------------------
; Ruler:        Generates a "1234567890"-style ruler at X,Y in text buffer
; UPDATED:      5/10/2023
; IN:           The 1-based X position (row #) is passed in RBX
;               The 1-based Y position (column #) is passed in RAX
;               The length of the ruler in chars is passed in RCX
; RETURNS:      Nothing
; MODIFIES:     VidBuff
; CALLS:        Nothing
; DESCRIPTION:  Writes a ruler to the video buffer VidBuff, at the 1-based
;               X,Y position passed in RBX,RAX. The ruler consists of a
;               repeating sequence of the digits 1 through 0. The ruler
;               will wrap to subsequent lines and overwrite whatever EOL
;               characters fall within its length, if it will not fit
;               entirely on the line where it begins. Note that the Show
;               procedure must be called after Ruler to display the ruler
;               on the console.

Ruler:  
    push rax         ; Save the registers we change
    push rbx
    push rcx
    push rdx
    push rdi

    mov rdi,VidBuff   ; Load video buffer address to RDI
    dec rax           ; Adjust Y value down by 1 for address calculation
    dec rbx           ; Adjust X value down by 1 for address calculation
    mov ah,COLS       ; Move screen width to AH
    mul ah            ; Do 8-bit multiply AL*AH to AX
    add rdi,rax       ; Add Y offset into vidbuff to RDI
    add rdi,rbx       ; Add X offset into vidbuf to RDI
        
; RDI now contains the memory address in the buffer where the ruler
; is to begin. Now we display the ruler, starting at that position:
    mov rdx,RulerString  ; Losd address of ruler string into RDX

DoRule: 
    mov byte al,[rdx] ; Load first digit in the ruler to AL
    stosb             ; Store 1 char; note that there's no REP prefix!
    inc rdx           ; Increment RDX to point to next char in ruler string
    loop DoRule       ; Decrement RCX & Go back for another char until RCX=0

    pop rdi           ; Restore the registers we saved
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret    

;-------------------------------------------------------------------------
; MAIN PROGRAM:
;-------------------------------------------------------------------------	
main:
    mov rbp,rsp

; Get the console and text display text buffer ready to go:
    call ClearTerminal  ; Send terminal clear string to console
    call ClrVid         ; Init/clear the video buffer

; Show a 64-character ruler above the table display:
    mov rax,1           ; Start ruler at display position 1,1
    mov rbx,1
    mov rcx,32          ; Make ruler 32 characters wide
    call Ruler          ; Generate the ruler

; Now let's generate the chart itself:
    mov rdi,VidBuff     ; Start with buffer address in RDI
    add rdi,COLS*CHRTROW    ; Begin table display down CHRTROW lines
    mov rcx,224         ; Show 256 chars minus first 32
    mov al,32           ; Start with char 32; others won't show
.DoLn:	mov bl,CHRTLEN  ; Each line will consist of 32 chars
.DoChr:	stosb           ; Note that there's no REP prefix!
    jrcxz AllDone       ; When the full set is printed, quit
    inc al              ; Bump the character value in AL up by 1
    dec bl              ; Decrement the line counter by one
    loopnz .DoChr       ; Go back & do another char until BL goes to 0
    add rdi,COLS-CHRTLEN   ; Move RDI to start of next line
    jmp .DoLn           ; Start display of the next line

; Having written all that to the buffer, send the buffer to the console:
AllDone:
    call Show           ; Refresh the buffer to the console
Exit:
    ret
