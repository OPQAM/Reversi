.bss -> block starting symbol

This section is used for reserving space in memory.

NOTE: we need to first move 1 into a byte sized structure - the register 'bl', in fact, and only then can we place that into [num]. We cannot do it directly. x86 doesn't know how big [num] is or how big the thing we're moving into [num] is.

NOTE: [num] is the first memory location. If we wanted the next location, we would do, of course, [num+1]. Remember that +1 means +1 byte. If we wanted the position 4 bytes next to it, we would do +4.

We can also do something similar in the .data section, but instead of reserving  bytes, we can actually define with a default value:

section .data
        num2 DB 3 DUP(2) -> will write '2' into memory three times.
