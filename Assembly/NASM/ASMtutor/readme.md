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

#### Subroutines

Subroutines are functions. We don't use them with jumps, but with CALL and RET. CALL and RET let's us re-use our subroutines.

CALL pushes the return address (the instruction immediately after the CALL) onto the stack. RET pops that and jumps there.

---

#### Callee-saved and Caller-saved Registers

Callee-saved must be put back by the callee. While Caller-saved might be trashed and the caller must expect them to be trashed.

So, **EBX, EBP, ESI and EDI are Callee-Saved registers.** They must be preserved by the function if hey are used.

Hence, in program 03, we see this:

    26 strlen:
    27     push    ebx 
We'll be using EBX later, and so we push it onto the stack so that we later can pop it back and keep it with its original value. In this specific exercise, it matters not, since we weren't depending on EBX, but on other programs that might just be the case.
Even though EBX isn’t critical here, following the convention keeps the function “ABI-safe” and makes it reusable in larger programs.

Other registers, like **EAX, ECX and EDX are Caller-saved.** So the caller cannot really expect them to survive a function call.

---

#### No Linefeed for me, please

We want to write a subroutine, in order to stop constantly having to write '0Ah' in all our messages. This is added into functions.asm as sprintLF:. This allows us to stop writing messages like
    msg3    db      'My message', 0Ah, 0h
And instead do 
    msg     db      'My message', 0h

sprintLF: substituted the simpler sprint: which was:
        push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret

---

#### Passing Arguments into the program

   ^                    **THE STACK**
   |
   |            | **nr of passed arguments** |
   |            |      **program name**      |
   |            |      **Argument 2*         |
                |      **Argument 1**        |
                |          **...**           |

---

#### The .bss section

##### BLOCK Started by Symbol (BSS), is an area of the program used to reserve space in memory for uninitialised variables.

Ex:

    SECTION .bss                        ; Reserving space for:
    variableName1:      RESB    1       ; 1 byte
    variableName2:      RESW    1       ; 1 word
    variableName3:      RESD    1       ; 1 double word
    variableName4:      RESQ    1       ; 1 double precision float
    variableName5:      REST    1       ; 1 extended precision float

---

#### Namespace

Necessary in any software project that involves a codebase larger than a few functions. It provides scope to the identifiers and allows the reuse of naming conventions - for readability and maintainability. In ASM, subroutines are identified by global labes, so namespace can be achieved by using local labels.

Local labels are prepended with a '.' at the beginning of their name.


