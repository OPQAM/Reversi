;----------------------------------------
; Constants / Equates
SYS_EXIT        equ 1       ; syscall number for exit
SYS_WRITE       equ 4       ; syscall number for write
STDOUT          equ 1       ; file descriptor 1 = stdout
LINEFEED        equ 10      ; linefeed character (0Ah)


;----------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax              ; preserve eax, ecx, edx and esi on 
    push    ecx              ; the stack to be restored after function
    push    edx              ; runs
    push    esi
    mov     ecx, 0           ; this is a counter of how many bytes we
                             ; have to print in the end
divideLoop:
    inc     ecx
    mov     edx, 0           ; empty edx
    mov     esi, 10
    idiv    esi              ; divide eax by esi
    add     edx, 48          ; convert edx to ASCII (the remainder)
    push    edx              ; place result on the stack
    cmp     eax, 0           ; can we divide the integer any more?
    jnz     divideLoop

printLoop:
    dec     ecx              ; remove bytes we place on stack
    mov     eax, esp         ; move stack pointer for printing
    call    sprint           ; string printing function is called
    pop     eax              ; remove last character from stack to 
                             ; move esp forward
    cmp     ecx, 0           ; check if all characters were printed
    jnz     printLoop

    pop     esi              ; restore esi, edx, ecx, eax, from the
    pop     edx              ; value we pushed onto the stack at
    pop     ecx              ; the start
    pop     eax
    ret


;----------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call integer printing function

    push    eax
    mov     eax, 0Ah        ; move linefeed character onto the stack
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax             ; remove linefeed char from the stack
    pop     eax             ; restore original value of eax
    ret


;----------------------------------------
; int slen(String message)
;-------------------------
; Calculate length of null-terminated string
;
; Input: EAX = pointer to the first byte of the string
; Output: EAX = length of string (# of bytes before null terminator)

slen:
    ;----------------------------------------
    ; Preserve EBX (callee-saved register)
    push    ebx             ; Save EBX on the stack

    ;----------------------------------------
    ; Store starting pointer in EBX
    mov     ebx, eax

nextchar:
    ;----------------------------------------
    ; Loop through each character until null terminator is found
    cmp     byte [eax], 0   ; compare current byte to 0
    jz      finished        ; if 0 => jump to finished
    inc     eax             ; increase EAX by 1
    jmp     nextchar        ; repeat loop

finished:
    ;----------------------------------------
    ; Calculate the string length
    sub     eax, ebx        ; EAX = current ptr - start ptr
    pop     ebx             ; restore EBX before finishing
    ret                     ; return to caller. EAX = string length


;----------------------------------------
; void sprint(String message)
; String printing function
; Uses slen() to calculate string length
sprint:
    ;----------------------------------------
    ; Save registers that we will overwrite
    ; EAX, ECX, EDX are caller-saved
    ; EBX is callee-saved but we overwite it
    push    edx
    push    ecx
    push    ebx
    push    eax

    ;----------------------------------------
    ; Call slen(message)
    ; EAX = pointer to string (argument)
    call    slen            ; returns length in EAX

    ; Move length to EDX (sys_write expects it)
    mov     edx, eax

    ; Restore original string pointer to ECX for write syscall
    pop     eax             ; restore original pointer
    mov     ecx, eax        ; ECX = buf (sys_write)

    ; Setup write syscall
    mov     ebx, STDOUT     ; fd = 1 
    mov     eax, SYS_WRITE  ; (4)
    int     80h             ; invoke kernel

    ;----------------------------------------
    ; Restore saved registers
    pop     ebx
    pop     ecx
    pop     edx

    ret


;----------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint

    push    eax             ; push eax onto  stack while we use here
    mov     eax, LINEFEED   ; ascii value of linefeed on eax now
                            ; eax = 4 bytes wide, so 0000000Ah
    push    eax             ; push linefeed onto stack. But remember
                            ; that we have a little-endian achitecture
                            ; so it's stored as 0Ah, 0h, 0h, 0h
                            ; linefeed and then a NULL terminated byte
    mov     eax, esp        ; move address of stack pointer to eax
    call    sprint          
    pop     eax             ; remove linefeed from stack
    pop     eax             ; restore eax before function call
    ret


;----------------------------------------
; void exit()
; Exit the program and restore resources
quit: 
    ;----------------------------------------
    ; Setup exit syscall
    mov     ebx, 0              ; Exit status value (success)
    mov     eax, SYS_EXIT       ; (1)
    int     80h                 ; invoke kernel
    ret
