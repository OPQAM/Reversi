section .data


section .text
global _start

_start:
        MOV eax,3
        MOV ebx,2
        CMP eax,ebx  ; eax - ebx (positive, zero or negative)
        JL lesser
        JMP end

lesser:
        MOV ecx,1

end:
        MOV ebx,0
        MOV eax,1
        INT 80h

        ; NOTE: the result of CMP eax,ebx isn't stored as an integer. Instead CPU flags are set (eflags register). We can then use JE, JG, JL, JNE, ... based on those flags.

        ; Useful Flags:
        ; ZF => Zero Flag
        ; SF => Sign Flag
        ; CF => Carry Flag
        ; OF => Overflow Flag

        ; We're using JMP here as a way to jump over the label 'lesser' and get directly to the end.
