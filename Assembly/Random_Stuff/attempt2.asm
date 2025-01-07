section .data
    fmt_before db "Before syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    fmt_after  db "After syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    msg        db "Hello, World!", 10, 0
    msg_len    equ $ - msg
    buf        resb 64                ; Buffer for formatted output

section .text
    global _start

_start:
    ; Prepare for sys_write
    mov eax, 4              ; sys_write system call number
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, msg            ; message to write
    mov edx, msg_len        ; message length

    ; Print the message to stdout
    int 0x80

    ; Print registers before syscall
    call print_registers_before

    ; Perform the syscall
    int 0x80

    ; Print registers after syscall
    call print_registers_after

    ; Exit syscall
    mov eax, 1              ; sys_exit system call number
    xor ebx, ebx            ; exit code 0
    int 0x80

print_registers_before:
    ; Save registers and prepare output
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    ; Format and write register values directly
    ; You will need to convert values to string format here
    ; This is just an outline, actual implementation will vary
    ; Store formatted string in buf and write it

    ret

print_registers_after:
    ; Similar to the above function
    ; Store formatted string in buf and write it

    ret

