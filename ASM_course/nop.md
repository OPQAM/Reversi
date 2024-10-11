; NOP - No-Operation. Just there to pad/align bytes, or delay time.
; Attackers use this to make simple exploits.
; NOP is a one byte instruction that is an alias mnemonic for
; XCHG (E)AX, (E)AX
; exchanges the values between registers. Does nothing.
; Cannonically is 0x90. But intel has different examples.

