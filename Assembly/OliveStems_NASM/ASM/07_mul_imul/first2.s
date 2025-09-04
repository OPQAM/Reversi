section .text
global _start

_start:
        MOV al,0xFF
        MOV bl,2
        MUL bl

        ; since multiplication will actually expand the bits we're using, we'll in fact get 0x1FE from the multiplication between 0x2 and 0xFF

