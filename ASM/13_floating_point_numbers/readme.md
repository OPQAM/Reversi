# Notes on Floating-Point numbers


Floating point numbers take 32 bits.
Doubles take 64 bits

DD - Define doubleword (32 bits)

MOVSS - Move scalar single precision (to be able to move devimal values)

Scalar = a single value moved in

Packed-data = several values being moved in.

### Special Registers

We use xmm0 to xmm15, which are special registers, to deal with these floats. These are 128-bit registers used by SSE and new SIMD instructions. but with MOVSS, only the lower 32 bits matter.

### Printing values in gdb

(gdb) p $xmm0.v4_float[0]

For doubles we would do:

(gdb) p $xmm0.v2_double[0]

---

### Precision issues. Floats aren't decimals 

IEEE floating point notation - trying to represent decimals as accurately as possible - powers of 2 issues. Dig into this.


