;  Executable name : timetest
;  Version         : 3.0
;  Created date    : 11/28/2022
;  Last update     : 11/28/2022
;  Author          : Jeff Duntemann
;  Description     : A demo of time-related functions for Linux, using
;                    NASM 2.14.02
;
;  Build using these commands:
;    nasm -f elf64 -g -F stabs timetest.asm
;    gcc timetest.o -o timetest -no-pie
;

[SECTION .data]         ; Section containing initialised data

TimeMsg  db "Hey, what time is it?  It's %s",10,0
YrMsg	 db "The year is %d.",10,10,0
PressEnt db "Press enter after a few seconds: ",0
Elapsed  db "A total of %d seconds has elapsed since program began running.",10,0	
	
[SECTION .bss]          ; Section containing uninitialized data

OldTime	 resq 1         ; Reserve 3 quadwords for time_t values
NewTime  resq 1
TimeDiff resq 1	
TimeStr  resb 40        ; Reserve 40 bytes for time string
TmCopy	 resd 9         ; Reserve 9 integer fields for time struct tm			

[SECTION .text]         ; Section containing code

extern ctime
extern difftime
extern getchar
extern printf
extern localtime	
extern strftime	
extern time
									
global main             ; Required so linker can find entry point
	
main:
    push rbp            ; Set up stack frame
    mov rbp,rsp
    
;;; Everything before this is boilerplate; use it for all ordinary apps!	

; Generate a time_t calendar time value with clib's time function
    xor rdi,rdi         ; Clear rdi to 0
    call time           ; Returns calendar time in rax
    mov [OldTime],rax   ; Save time value in memory variable

; Generate a string summary of local time with clib's ctime function
    mov rdi,OldTime     ; Push address of calendar time value
    call ctime          ; Returns pointer to ASCII time string in rax

    mov rdi,TimeMsg     ; Pass address of base string in rdi
    mov rsi,rax         ; Pass pointer to ASCII time string in rsi
    call printf         ; Merge and display the two strings

; Generate local time values into libc's static tm struct
    mov rdi,OldTime     ; Push address of calendar time value
    call localtime      ; Returns pointer to static time structure in rax

; Make a local copy of libc's static tm struct
    mov rsi,rax         ; Copy address of static tm from rax to rsi
    mov rdi,TmCopy      ; Put the address of the local tm copy in rdi
    mov rcx,9           ; A tm struct is 9 dwords in size under Linux
    cld                 ; Clear DF so we move up-memory
    rep movsd           ; Copy static tm struct to local copy

; Display one of the fields in the tm structure
	mov rdx,[TmCopy+20] ; Year field is 20 bytes offset into tm
	add rdx,1900        ; Year field is # of years since 1900
	mov rdi,YrMsg       ; Put address of the base string into rdi
    mov rsi,rdx
	call printf         ; Display string and year value with printf

; Display the 'Press Enter: ' prompt
    mov rdi,PressEnt    ; Put the address of the base string into rdi
    call printf

; Wait a few seconds for user to press Enter so we have a time difference:
    call getchar        ; Wait for user to press Enter

; Calculating seconds passed since program began running:
    xor rdi,rdi         ; Clear rdi to 0
    call time           ; Get current time value; return in EAX
    mov [NewTime],rax   ; Save new time value

    sub rax,[OldTime]   ; Calculate time difference value
    mov [TimeDiff],rax  ; Save time difference value

    mov rsi,[TimeDiff]  ; Put difference in seconds rdi
    mov rdi,Elapsed     ; Push addr. of elapsed time message string
    call printf         ; Display elapsed time
		
;;; Everything after this is boilerplate; use it for all ordinary apps!

    mov rsp,rbp         ; Destroy stack frame before returning
    pop rbp

    ret                 ; Return to glibc shutdown code
