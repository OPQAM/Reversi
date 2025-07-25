# Notes

Please check the ASM script. Notes within.

Remember that you can actually check the flags present with:

. (gdb) info register eflags

Also, remember that you can actually print the raw flag bits (bitfield).

. (gdb) p/t $eflags

This is a set of 12 bits:

BIT | Name
0   | CF (Carry)
1   | Reserved (Always 1 on Intel CPUs)
2   | PF (Parity)
3   | AF (Auxiliary Carry Flag)
4   | Reserved
5   | Reserved
6   | ZF (Zero)
7   | SF (Sign)
8   | TF (Trap)
9   | IF (Interrupt Enable)
10  | DF (Direction)
11  | OF (Overflow)
12  | (etc)
Ex:
(gdb) info reg eflags
eflags         0x202               [ IF ]
(gdb) p/t $eflags
$1 = 1000000010
***So, bit 1 and 9***


