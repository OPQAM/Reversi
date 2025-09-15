# Notes on NASM Assembly Language Tutorials

##### https://asmtutor.com/

---

. nasm -f elf filename.asm
. ld -m elf_i386 filename.o -o filename

---

#### Linux System Call table
##### https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/#x86-32-bit

##### Let's look at Syscalls

*Sys_write* -> Writing a character string to stdout (as an example)

**In C:**

    #include <unistd.h>

    ssize_t write(int fd, const void buf[.count], size_t count);

**Syscall table:**

**NR | syscall name | eax | arg0 (ebx)     | arg1 (ecx)     | arg2 (edx)**
  4    write          0x04  unsigned int fd  const char *buf  size_t count

**Use in ASM:**

    mov edx, 13                      ; bytes to write
    mov ecx, msg
    mov ebx, 1                       ; write to STDOUT
    mov eax, 4                       ; SYS_WRITE (kernel opcode 4)
    int 80h

NOTES:

- So, as we can see, the table is only showing us that ebx→fd, ecx→buf, edx→count (fd = 'file descriptor').
- It is showing us the translation between the C API and the register-level ABI (Application Binary Interface).
- size_t usually means number of bytes (not characters) not null terminated.
- Man pages can tell us more (ex: 'man 2 write', in general 'man 2 syscallname')

---

Linux man pages sections:

**man 1** → user commands (ls, cat, etc.)
**man 2** → system calls (read, write, open, …)
**man 3** → C library functions (printf, strcpy, …)
**man 4** → device files
**man 5** → file formats
**man 7** → conventions, overview docs
**man 8** → admin commands

---


