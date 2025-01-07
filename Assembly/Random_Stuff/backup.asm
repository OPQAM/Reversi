section .data
    ftm_before db "Before syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    ftm_after db "After syscall - EAX: %x, EBX: %x, ECX: %x, EDX: %x", 10, 0
    msg db "Hello, World!", 10, 0
    msg_len eq $ - msg

section .text
    global _start
    extern printf

print_registers:
    push edx
    push ecx
    push ebx
    push eax
    push dword [esp + 20] ; push format string address
    call printf
    add esp, 20 ; clean up stack

_start:
    ; Prepare for sys_write
    mov eax, 4  ; sys_write system call number
    mov ebx, 1  ; file descriptor (stdout)
    mov ecx, msg ; message to write
    mov edx, msg_len ; message length

    ; Print registers before syscall
    push fmt_before
    call print_registers


    ; Exit program
    mov eax, 1    ; sys_exit sys call number
    xor ebx, ebx     ; exit code 0
    int 0x80
