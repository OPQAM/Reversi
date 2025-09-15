# Notes

### Following along OpenSecurityTraining2 Dbg1012Debuggers 1012: Introductory GDB


#### To NOT use GEF, and use vanilla GDB, use command 'gdb -nx'
#### (created alias in ~/.bashrc. Use 'gdbv' to run vanilla GDB)

---

### Loading file in gdb

#### fibber:
. gdb --quiet ./fibber_bin

##### OR
. gdb -1
. (gdb) file ./fibber_bin

---

### Useful commands

. info breakpoints ( or 'info break', 'info b', 'i b', ...  ---> Lists created breakpoints
. clear <adress> (use name or '*address')                   ---> Remove the breakpoint
. delete <breakpoint number>  (or 'd' instead of 'delete')  ---> Ditto, using listed number
. disable <breakpoint number>                               ---> We can see them with 'info break'
. enable <breakpoint number>

. list                                                      ---> show source code surrounding current location
. list <function name>                                      ---> source code around function
. list <source file name>:<line number>
. disassemble (or 'disas', can use /r for raw bytes or /m for code and assembly)
. disassemble <address or symbol name>
. display/10i <instruction pointer / program counter>       ---> this form of 'display' will ensure that every time the program stops, some number of instructions (10 here) are printed out, starting at the given address. EX (x86 systems):
. display/10i $rip

. stepi (or 'si')                                           ---> Steps into the next instruction
.nexti (or 'ni')                                            ---> Steps over the next instruction
. finish (or 'ifn')                                         ---> Steps out of the current function context EX:
. display/10i $rip
. ni
...

#### Format Specifiers
/FMT, the format specifier takes in a '/', a number 'n', a format specifier 'f', and a unit size specifier 'u'. Each of these elements are optional (defaulting to last-used values or initial values)

So, 'display/10i' has n = 10 and f = instruction

##### Most common values for format specifier 'f':

*x* --> hexadecimal
*d* --> signed decimal
*u* --> unsigned decimal
*c* --> ASCII characters
*s* --> full ASCII string

##### Unit sizes of 'u':

*b* --> bytes
*h* --> half words (2 bytes)
*w* --> words (4 bytes)
*g* --> giant-words (8 bytes)

(Note: In Intel, a word is 2 bytes; in RISC-V 8 bytes unit sizes are 'double-words' not 'giant-words')

---

#### Viewing Registers

. info registers (or 'info r')                              ---> will print out more commonly needed registers
. info registers <specific register>
EX: 'i r rax rbx rsp' ('info registers rax rbx rsp'. Notice we don't need a '$')
. print/F <EX: 'p/x $rax'>                                  ---> to print a single register (needs '$')

---

#### Examining Memory

'x' ------> Examine memory (supports /FMT)

Examples:
. x/8xb $rsp
. x/4xh $rsp
. x/3i $rip

---

#### Modifying Registers

. set <register> = <value>                                  --->EX: 
. set $rax = 0xdeadbeeff00dface

---

#### Modifying Memory

Just like registers, memory can be modified with the 'set' command.

EX:
. x/1xg $rbx
0x7fffffffdfd8:	0x00007fffffffe2f0
. set {char}$rbx = 0xFF
. x/1xg $rbx
0x7fffffffdfd8:	0x00007fffffffe2ff
. set {short}$rbx = 0xFF
. x/1xg $rbx
0x7fffffffdfd8:	0x00007fffffff00ff

(note that {short} did not sign-extend the 1-byte value to the 2-byte short of 0xFFFF. There is, instead, zero-extension of the 0xFF to 0x00FF)

. set {long long}$rbx = 0x1337bee7
. x/1xg $rbx
0x7fffffffdfd8:	0x000000001337bee7

---

#### Updating the Stack View

. display/FMT <register>                                    ---> EX:
. display/10xg $rsp

---

#### Stack Backtrace

This will provide a call stack backtrace (short form is 'bt').

---

#### Temporary Breakpoints

. until <address> (or 'u')                                  ---> Note that the command will break upon exit of the function if the address is never reached. This command will jump us directly to the breakpoint we want. Ex:
. u *0x000055555555551e5

---

#### Saving a Persistent GDB Configuration

First, create the file where you'll be wanting to store the config (e.g. ~/x.cfg). Then, specify that file with the -x option:
. -x ~/x.cfg

Textbook example of commands to be saved to the.cfg file (Intel x86-64):

display/10i $rip
display/x $rbp
display/x $rsp
display/x $rax
display/x $rbx
display/x $rcx
display/x $rdx
display/x $rdi
display/x $rsi
display/x $r8
display/x $r9
display/x $r12
display/x $r13
display/x $r14
display/10gx $rsp
start

Example of running this as we open gdb:
. gdb -q -x ~/opqam/GDB/test.cfg fibber_bin 

(we can easily create an alias for this, for example - standardizing the opening of projects - maybe a function instead of an alias?)

---


