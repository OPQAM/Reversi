;  Executable name : randtest
;  Version         : 3.0
;  Created date    : 11/29/2022
;  Updated date    : 7/18/2023
;  Author          : Jeff Duntemann
;  Description     : A demo of Unix rand & srand using NASM 2.14.02
;
;  Build using these commands or the makefile:
;    nasm -f elf64 -g -F dwarf randtest.asm
;    gcc randtest.o -o randtest
;

section .data

Pulls      dq 36 ; How many numbers do we pull? (Must be a multiple of 6!)
Display    db 10,'Here is an array of %d %d-bit random numbners:',10,0
ShowArray  db '%10d %10d %10d %10d %10d %10d',10,0
NewLine    db 0		
CharTbl    db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-@'

section .bss

[SECTION .bss]          ; Section containing uninitialized data

BUFSIZE  equ 70         ; # of randomly chosen chars
RandVal  resq 1         ; Reserve an integer variable
Stash    resq 72        ; Reserve an array of 72 integers for randoms
RandChar resb BUFSIZE+5 ; Buffer for storing randomly chosen characters

section .text

extern printf	
extern puts
extern rand
extern scanf	
extern srand
extern time	

;------------------------------------------------------------------------------
;  Random number generator procedures  --  Last update 5/13/2023
;
;  This routine provides 6 entry points, and returns 6 different "sizes" of
;  pseudorandom numbers based on the value returned by rand. Note first of 
;  all that rand pulls a 31-bit value. The high 16 bits are the most "random"
;  so to return numbers in a smaller range, you fetch a 31-bit value and then
;  right-shift it to zero-fill all but the number of bits you want. An 8-bit
;  random value will range from 0-255, a 7-bit value from 0-127, and so on.
;  Respects RBP, RSI, RDI, RBX, and RSP. Returns random value in RAX.
;------------------------------------------------------------------------------
pull31: mov rcx,0       ; For 31 bit random, we don't shift
	jmp pull
pull20: mov rcx,11      ; For 20 bit random, shift by 11 bits
    jmp pull
pull16: mov rcx,15      ; For 16 bit random, shift by 15 bits
	jmp pull
pull8:  mov rcx,23      ; For 8 bit random, shift by 23 bits
	jmp pull
pull7:  mov rcx,24      ; For 7 bit random, shift by 24 bits
	jmp pull
pull6:  mov rcx,25      ; For 6 bit random, shift by 25 bits
	jmp pull
pull4:  mov rcx,27      ; For 4 bit random, shift by 27 bits

pull:	
    push rcx            ; rand trashes rcx; save shift value on stack
    call rand           ; Call rand for random value; returned in RAX
    pop rcx             ; Pop stashed shift value back into RCX
    shr rax,cl          ; Shift the random value in RAX by the chosen factor
                        ;  keeping in mind that part we want is in CL
    ret                 ; Go home with random number in RAX

;; This subroutine pulls random values and stuffs them into an
;; integer array.  Not intended to be general purpose.  Note that
;; the address of the random number generator entry point must
;; be loaded into r13 before this is called, or you'll seg fault!

puller:
    mov r12,[Pulls]     ; Put pull count into R12
.grab:
    dec r12             ; Decrement counter in RSI
    call r13            ; Pull the value; it's returned in RAX
    mov [Stash+r12*8],rax   ; Store random value in the array
    cmp r12,0           ; See if we've pulled all STASH-ed numbers yet
    jne .grab           ; Do another if R12 <> 0 
    ret                 ; Otherwise, go home!

    ;; This subroutine displays numbers six at a time
    ;; Not intended to be general-purpose...
shownums:	
    mov r12,qword [Pulls]    ; Put pull count into r12
    xor r13,r13
.dorow:	
    mov rdi,ShowArray        ; Pass address of base string
    mov rsi,[Stash+r13*8+0]  ; Pass first element
    mov rdx,[Stash+r13*8+8]  ; Pass second element
    mov rcx,[Stash+r13*8+16] ; Pass third element
    mov r8,[Stash+r13*8+24]  ; Pass fourth element
    mov r9,[Stash+r13*8+32]  ; Pass fifth element
    push qword [Stash+r13*8+40] ; Pass sixth element on the stack.
    call printf              ; Display the random numbers
    add rsp,8                ; Stack cleanup: 1 item X 8 bytes = 8
	
    add r13,6       ; Point to the next group of six randoms in Stash 
    sub r12,6       ; Decrement pull counter
    cmp r12,0       ; See if pull count has gone to 0
    ja .dorow       ; If not, we go back and do another row!
    ret             ; Done, so go home!

; MAIN PROGRAM:
					
global main         ; Required so linker can find entry point
	
main:
    push rbp        ; Set up stack frame
	mov rbp,rsp
	
;;; Everything before this is boilerplate; 

; Begin by seeding the random number generator with a time_t value:	

Seedit:	
    xor rdi,rdi		; Mske sure rdi starts out with a 0
    call time	    ; Returns time_t value (64-bit integer) in rax
    mov rdi,rax	    ; Pass srand a time_t seed in rdi
    call srand	    ; Seed the random number generator

; All of the following code blocks are identical except for the size of
; the random value being generated:
	
; Create and display an array of 31-bit random values
    mov r13,pull31  ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,32      ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 20-bit random values
    mov r13,pull20  ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
		
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,20      ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 16-bit random values
    mov r13,pull16  ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,16      ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 8-bit random values
    mov r13,pull8   ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
    	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,8       ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 7-bit random values
    mov r13,pull7   ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,7       ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 6-bit random values
    mov r13,pull6   ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,6       ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Create and display an array of 4-bit random values
    mov r13,pull4   ; Copy address of random # subroutine into RDI
    call puller     ; Pull as many numbers as called for in [Pulls]
	
    mov rdi,Display ; Display the base string
    mov rsi,[Pulls] ; Display the number of randoms displayed
    mov rdx,4       ; Display the size of the randoms displayed
    call printf     ; Display the label
    call shownums   ; Display the rows of random numbers

; Clear a buffer to nulls:
Bufclr:	
    mov rcx, BUFSIZE+5  ; Fill whole buffer plus 5 for safety
.loop:	
    dec rcx             ; BUFSIZE is 1-based so decrement first!
    mov byte [RandChar+rcx],0     ; Mov null into the buffer
    cmp rcx,0           ; Are we done yet?
    jnz .loop           ; If not, go back and stuff another null

; Create a string of random alphanumeric characters:
Pulchr:	
    mov rbx, BUFSIZE    ; BUFSIZE tells us how many chars to pull
.loop:	
    dec rbx             ; BUFSIZE is 1-based, so decrement first!
    mov r13,pull6       ; For random in the range 0-63
    call r13
    mov cl,[CharTbl+rax]  ; Use random # in rax as offset into table
                          ;  and copy character from table into CL
    mov [RandChar+rbx],cl ; Copy char from CL to character buffer
    cmp rbx,0           ; Are we done having fun yet?
    jne .loop           ; If not, go back and pull another

; Display the string of random characters:
    mov rdi,NewLine     ; Output a newline
    call puts           ;  using the newline procedure
    mov rdi,RandChar    ; Push the address of the char buffer 
    call puts           ; Call puts to display it
    mov rdi,NewLine     ; Output a newline
    call puts

;;; Everything after this is boilerplate; use it for all ordinary apps!

    mov rsp,rbp         ; Destroy stack frame before returning
    pop rbp

    ret                 ; Return to glibc shutdown code

