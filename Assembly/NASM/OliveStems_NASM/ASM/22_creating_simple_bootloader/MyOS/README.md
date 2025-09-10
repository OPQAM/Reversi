# Notes on the BIOS boot sector

The BIOS reads 512 bytes from the boot device into _physical address 0x000:0x7C00_, then jumps there.
The last two bytes must be 0x55AA.

#### Q: What does it mean to write DS:SI = 0:7C00 what is this notation? What is DS:SI?

Let DS = 0x1000 & SI = 0x0020
physical_address = segment * 16 + offset

So, 0x1000 * 16 + 0x0020 = 0x10000 + 0x20 = 0x10020

So... DS:SI literally means _the memory at segment register DS, plus offset in SI_
In the bootloader, DS = 0, so DS:SI = 0 * 16 + SI, which == SI.

This way, if SI = 0x7C00 we're pointing exactly to the start of the boot sector in memory.

---
#### Q: CLI? STI?

cli = _Clear Interrupt Flag_ (disables hardware interrupts)
sti = _Set Interrupt Flag_ (enables them again)

---
#### Q: We care, why?

When we change the stack segment (SS) and the stack pointer (SP), we're messing with where the CPU will push things.
If a hardware interrupt fires right as we change SS the CPU will try to push flags/CS/IP onto the stack, we might corrupt memory and crash
So, safe sequence:

cli        ; stop interrupts
mov ss,ax
mov sp,...
sti        ; resume state

---
#### Q: How is memory actually laid out?

##### 0000:0000 --------------+
#####           ...           | BIOS data structures, IVT (_Interrupt Vector Table_), BDS (_BIOS Data Area_)
##### 0000:0500 --------------+
#####           ...           | Free RAM, usually unnused by BIOS (stack grows downward. We write here and ^^^)
##### 0000:7C00 --------------+ <--- Boot sector loaded here (512 bytes, total)
##### 0000:7DFF --------------+

We're safe writing there, as long as we _don't push too down_, because eventually we'll overwrite BIOS data lower down, like at 0x0500 and below.

---
#### Q: LODSB?
 
LODSB (_load string byte_) reads one byte from memory at DS:SI into AL, then adjusts SI by ±1 depending on the DF (_direction flag_)
Our print loop needs to fetch bytes from the message string one at a time. LODSB does that in one instruction, instead of two separate memory + increment instructions.

Since LODSB does not change CPU flags, we need to use another instruction, like TEST or OR to set the ZF so we can JZ when we hit the string terminator.
Also, LODSB implicitly uses DS:SI.

---
#### Q: Direction Flag (DF)?

The Direction Flag defines whether string instructions like LODSB, MOVSB, STOSB move forward (increment) or backward (decrement).
So, in our case with SI, DF = 0 (SI increments), DF = 1 (SI decrements).

CLD = Clear DF (sets DF=0)
STD = Set DF   (sets DF=1)

##### Small gotcha:
-> Most code expects forward string transversal. But DF is a global CPU flag - _some other code (or BIOS routines) might have changed it_. If we rely on it being 0 without setting it, we're gambling.

Rule of Thumb: explicitly CLD before using LODSB (unless we absolutely control the CPU's prior state)

