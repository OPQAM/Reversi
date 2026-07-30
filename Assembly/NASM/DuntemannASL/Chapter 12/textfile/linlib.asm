;  Source name     : linlib.asm
;  Executable name : None -- This is a library of subroutines!
;  Version         : 3.0
;  Created date    : 12/4/1999
;  Last update     : 12/10/2022
;  Author          : Jeff Duntemann
;  Description     : A procedure library in assembly using NASM 2.14.02
;
;  Assemble using this command:
;    nasm -f elf64 -g -F dwarf linlib.asm

[SECTION .data]		; Section containing initialised data

LineBase    db 'Number is: %d',10,0
nl	        db 10,10,10,10,10,10,10,10,10,10,0	

[SECTION .bss]		; Section containing uninitialized data

[SECTION .text]		; Section containing code

extern printf		; All of these are in the standard C library glibc	
extern rand	
extern srand
extern time
		
global seedit		; Seeds the random number generator with a time value
global pull31		; Pulls a 31-bit random number
global pull16		; Pulls a 16-bit random number; in the range 0-65,535
global pull8		; Pulls an 8-bit random number; in the range 0-255
global pull7		; Pulls a 7-bit random number; in the range 0-127
global pull6		; Pulls a 6-bit random number; in the range 0-63
global pull4		; Pulls a (marginal) 4-bit random number; range 0-15
global newline		; Outputs a specified number of newlines to stdout
	

;------------------------------------------------------------------------------
;  Random number generator procedures  --  Last update 12/10/2022
;
;  This routine provides 6 entry points, and returns 6 different "sizes" of
;  pseudorandom numbers based on the value returned by rand. Note first of 
;  all that rand pulls a 31-bit value. The high 16 bits are the most "random"
;  so to return numbers in a smaller range, you fetch a 31-bit value and then
;  right-shift it to zero-fill all but the number of bits you want. An 8-bit
;  random value will range from 0-255, a 7-bit value from 0-127, and so on.
;  Respects RBP, RSI, RDI, RBX, and RSP. Returns random value in RAX.
;------------------------------------------------------------------------------
pull31: mov rcx,0		; For 31 bit random, we don't shift
	jmp pull
pull20: mov rcx,11      ; For 20 bit random, shift by 11 bits
    jmp pull
pull16: mov rcx,15		; For 16 bit random, shift by 15 bits
	jmp pull
pull8:	mov rcx,23		; For 8 bit random, shift by 23 bits
	jmp pull
pull7:  mov rcx,24		; For 7 bit random, shift by 24 bits
	jmp pull
pull6:	mov rcx,25		; For 6 bit random, shift by 25 bits
	jmp pull
pull4:	mov rcx,27		; For 4 bit random, shift by 27 bits

pull:	
    push rcx		; rand trashes rcx; save shift value on stack
	call rand		; Call rand for random value; returned in RAX
	pop rcx			; Pop stashed shift value back into RCX
	shr rax,cl		; Shift the random value in RAX by the chosen factor
				    ;  keeping in mind that part we want is in CL
	ret			    ; Go home with random number in RAX

;---------------------------------------------------------------------------
;  Random number seed routine  --  Last update 12/10/2022
;
;  This routine fetches a time_t value from the system clock using the C
;  library's time function, and uses that time value to seed the random number    
;  generator through the function srand.  No values need be passed into it    
;  nor returned from it.                                                     
;---------------------------------------------------------------------------

seedit:	
    xor rdi,rdi		; Mske sure rdi starts out with a 0
	call time	    ; Returns time_t value (64-bit integer) in rax
	mov rdi,rax	    ; Pass srand a time_t seed in rdi
	call srand	    ; Seed the random number generator
    ret             ; No return value

;------------------------------------------------------------------------------
;  Newline outputter  --  Last update 5/29/2009
;
;  This routine allows you to output a number of newlines to stdout, given by
;  the value passed in rax.  Legal values are 1-10. Passing a 0 value in rax 
;  will result in no newlines being issued.
;------------------------------------------------------------------------------

newline:
	mov rcx,10		; We need a skip value, which is 10 minus the
	sub rcx,rax		;   number of newlines the caller wants.
	add rcx,nl		; This skip value is added to the address of
	mov rdi,rcx		;   the newline buffer nl before calling printf.
	call printf		; Display the selected number of newlines
	ret			; Go home

