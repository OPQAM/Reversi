;----------------------------------------
; Constants / Equates
SYS_EXIT        equ 1       ; syscall number for exit
SYS_WRITE       equ 4       ; syscall number for write
STDOUT          equ 1       ; file descriptor 1 = stdout
EXIT_SUCCESS    equ 0       ; program exit code

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
; Print null-terminated string to STDOUT
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
    mov     ebx, STDOUT     ; fd = 1 (STDOUT)
    mov     eax, SYS_WRITE  ; number = 4 (sys_write)
    int     80h             ; invoke kernel

    ;----------------------------------------
    ; Restore saved registers
    pop     ebx
    pop     ecx
    pop     edx

    ret

;----------------------------------------
; void exit()
; Exit the program and restore resources
quit: 
    ;----------------------------------------
    ; Setup exit syscall
    mov     ebx, EXIT_SUCCESS   ; Exit status value (0)
    mov     eax, SYS_EXIT       ; number = 1 (sys_exit)
    int     80h                 ; invoke kernel
    ret
