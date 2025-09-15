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

    ssize_t write(unsigned int fd, const char *buf, size_t count);

**Syscall table:**

**NR | syscall name | eax | arg0 (ebx)     | arg1 (ecx)     | arg2 (edx)**
  4    write          0x04  unsigned int fd  const char *buf  size_t count

**Use in ASM:**

    mov edx, 13                      ; bytes to write
    mov ecx, msg
    mov ebx, 1                       ; write to STDOUT
    mov eax, 4                       ; SYS_WRITE (kernel opcode 4)
    int 80h

