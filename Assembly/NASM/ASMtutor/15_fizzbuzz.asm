; Fizzbuzz
; Compile with: nasm -f elf 15_fizzbuzz.asm
; Link with: ld -m elf_i386 15_fizzbuzz.o -o fizzbuzz
; Run with: ./fizzbuzz

%include        'functions.asm'

SECTION .data
fizz        db      'Fizz', 0h
buzz        db      'Buzz', 0h

SECTION .text
global  _start

_start:

    xor     esi, esi    ; checkFizz boolean variable
    xor     edi, edi    ; checkBuzz boolean variable
    xor     ecx, ecx    ; counter

nextNumber:
    inc     ecx
    
.checkFizz:
    xor     edx, edx    ; remainder (modulo operation)
    mov     eax, ecx    ; counter here to be divided
    mov     ebx, 3      
    div     ebx         ; edx:eax/ebx --> edx = remainder
    mov     esi, edx
    cmp     esi, 0      ; compare with checkFizz
    jne     .checkBuzz
    mov     eax, fizz   ; it is indeed divisible by 3
    call    sprint      ; print the string
    
.checkBuzz:
    xor     edx, edx
    mov     eax, ecx
    mov     ebx, 5
    div     ebx
    mov     edi, edx
    cmp     edi, 0
    jne     .checkInt   ; not divisible by 3 or 5 by now
    mov     eax, buzz
    call    sprint

.checkInt:
    cmp     esi, 0
    je      .continue
    cmp     edi, 0
    je      .continue
    mov     eax, ecx    ; put the non fizz/buzz number in eax to print
    call    iprint
    
.continue:
    mov     eax, 0Ah    ; linefeed
    push    eax
    mov     eax, esp    ; address of linefeed char
    call    sprint      ; print a linefeed
    pop     eax         ; pop stack to not waste resources
    cmp     ecx, 100
    jne     nextNumber

    call    quit
