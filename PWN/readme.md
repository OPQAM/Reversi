This is the folder for pwn.college classes and study sessions + random stuff found there
Entrypoint:
ssh -i key hacker@pwn.college

---

# .intel_syntax noprefix                 # that we're using intel and its variant
# .global _start                         # silencing the error about the starting position
# _start:                                # adding the start label

---
Assembling, linking and running the program:

# as -o asm.o asm.s
# ld -o my_executable asm.o
# ./my_executable

---

Interesting:

I was trying to create a program that would wait for 5 seconds and then end, using 'pause'
When I tried using syscall 35 I got an error (spotted in strace). Instead of trying
to run 'pause' it was running something called 'nanosleep' and returning an error.
Since I'm in x86-64, I can go and check /usr/include/asm/unistd_64.h

And lo and behold, I saw:

#define __NR_dup2 33
#define __NR_pause 34
#define __NR_nanosleep 35

So, yeah, I needed to change the value to 34.

---


