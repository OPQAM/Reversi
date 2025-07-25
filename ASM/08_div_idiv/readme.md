# NOTES

### Prep Stuff
I've altered the ~/.gdbinit:

set disassembly-flavor intel
set editing on
set history save on
set history filename ~/.gdb_istory
set history size 1000

This assures us that we can keep previous commands in memory and just use the up and down arrow to repeat certain commands. Quite useful.

I've also added a .gdb_history file, so as to make sure that it gets written.

When using the ASM TUI (layout asm) we lose that control again, since there are now two screen being used and the upper screen with the ASM code will scroll up and down. We can switch between screens with 'ctrl-x + o' and we can leave the TUI with 'ctrl-x + a'.

Also, remember we can check what command is at the top of the stack and about to be run with x/i $eip

---

### DIV

Apparently:
EAX = dividend and quotient
We pick the divisor (ex: ECX)
EDX = remainder

But this isn't the whole/real story.
In fact, our dividend is composed of a high and low value, constructed by EDX and EAX, thusly:

DIVIDEND = [EDX:EAX]
So, if our divisor is, ECX, then we get:
[EDX:EAX] / ECX = EAX + the Rest (R/d if you recall your math)

This means that if EAX = 0x1, EDX = 0x1 and ECX = 0x2, and we do:
DIV ecx,

This means that we'll get:
EAX = 0x80000000, EDX = 0x1

If you take a gander into gdb at EAX, gdb will assume that the most significant bit will change the sign, so 0x80000000 = -2147483648

Our division, in fact looks like: [0x00000001:0x00000001] / 0x00000002 = 0x80000000

Why? Ok, EAX holds the lower 32 bits and EDX holds the upper 32 bits of the full 64-bit dividend.


### IDIV
And IDIV is signed division

We need to use CDQ to make sure that EDX is also considering signed bits.

CDQ -> Convert Doubleword to Quadword
What does it do?

If EAX >= 0 => EDX = 0x00000000
IF EAX <  0 => EDX = 0xFFFFFFFF

Also, remember that we'll have smaller limits (about half) on the number of possible positive values, to account for the extra negatives we're havin.


#### NOTE: Be careful of using CDQ willy-nilly if we have a very large division, where the dividend is big enough to fill part of EDX, because CDQ will zero that and give us a result that might not be what we expect.

first3.s is a perfect example of why we should be aware of this stuff. We'd expect that from our division between 9 and -2 to get -4 with a remainder of 1. But nope. We get:
eax            0x7ffffffb          2147483643

This is because EDX wasn't properly initialized to work with IDIV
Again, be careful. There would be no issue if instead of dividing -9 by 2 we divided 9 by -2. But if we want' to do the original calculation, we need something like CDQ.

#### Check next examples, first4.s and first5.s for clarification and run them on gdb
Important to note that EDX will keep the sign of the dividend at all times, unlike what we see with DIV, where EDX >= 0 always.

All of this was very much hand-waived by the video, unfortunately.


### NOTE: 
#### Despite being a good tutorial, note here that Olivestem didn't mention how the division is actually working under the hood. Assuming that the dividend is just EAX is just relying on EDX being = 0 at the start, so computations are accidentally working. If, for some reasone, EDX is not 0 when you start your division, you will be surprised - to say the least.
#### If you need a smaller value, just make sure you zero EDX before any division.



The last file: test.s is there to showcase how EDX is fully writen when the division occurs.

CHECK: SIGFPE on 0x... values but not on direct decimals into EDX (!!!) Need to check asap.

Easy: the end result of the division NEEDS to fit 32 bits (EAX)...... if it's bigger than that, it overflows.


Also, note: GDB doesn't consider values as signed or unsigned. We need to tell it how to look at registers:

p/x $eax     ->   hex
p/d $eax     ->   signed decimal
p/u $eax     ->   unsigned decimal

So... if EAX = 0xfffffff6, then that's -10 signed, and 4294967286 signed.

