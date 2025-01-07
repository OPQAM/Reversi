section .data
    fmt_before db "Before syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    fmt_after  db "After syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    msg        db "Hello, World!", 10, 0
    msg_len    equ $ - msg

section .text
    global _start
    extern printf

print_registers:
    push ebp                ; save base pointer
    mov ebp, esp            ; set base pointer to stack pointer
    push eax                ; save registers
    push ebx
    push ecx
    push edx
    push dword [ebp + 8]    ; push format string address (from the stack)
    call printf
    add esp, 16             ; clean up stack (4 bytes for each pushed register)
    pop edx                 ; restore registers
    pop ecx
    pop ebx
    pop eax
    mov esp, ebp            ; restore stack pointer
    pop ebp                 ; restore base pointer
    ret

_start:
    ; Prepare for sys_write
    mov eax, 4              ; sys_write system call number
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, msg            ; message to write
    mov edx, msg_len        ; message length

    ; Print registers before syscall
    push fmt_before
    call print_registers
    int 0x80

    ; Print registers after syscall
    push fmt_after
    call print_registers

    mov eax, 1              ; sys_exit system call number
    xor ebx, ebx            ; exit code 0
    int 0x80
                                                                                                                         
