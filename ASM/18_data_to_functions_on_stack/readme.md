# Notes

### Use this:
. ld -m elf_i386 -o first first.o -e main

This way 'main' and not '\_start' is the entry point of our program.

We want to pass data through the stack since registers are precious resources.

Data might be too big, or we might not have enough free registers.

---
### Order of operations from code:
Push 4; Push 1; CALL addTwo (creating return address to next line, which is...); \[MOV ebx,eax\] (next step is the function addTwo); ...

     The  Stack
    |----------|
    |    EBP   | <--- ESP
    |----------|
    | ret addr | +4
    |----------|
    |     1    | +8
    |----------|
    |     4    | +12
    |----------|

### Note, though:

Inside the addTwo function we are doing PUSH ebp to the top of the stack, then we do MOV ebp,esp. Now both pointers (ebp = base pointer) are pointing towards the same location. We have created a divider there.
Now we're reference stuff in relation to ebp (ebp +4, ebp +8, etc).

---

Also, before ending our function and returning back to our main operation, we'll want to remove the EBP (to where the ESP is pointing to) and get to the return address. We POP ebp for that and RET.

Remember that ebx holds the return value and eax has the return code. eax needs to be 1 here, and we can echo $? to get our addition result.

---

### Checking what's in the stack:

(gdb)
. info register esp
. x/4x \<esp's memory location>
(we can see the esp location, the return address and the 1 & 4 on the stack)

