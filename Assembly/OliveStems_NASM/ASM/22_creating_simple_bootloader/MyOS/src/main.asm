BITS 16 ; We are in 16-bit real mode
ORG 0x7C00 ; BIOS loads boot sector to physical 0000:7C00

start:
; --- Establish known-good segment registers & stack ---
xor ax, ax ; ax = 0
mov ds, ax ; DS = 0 (so DS:SI points to physical addresses directly)
mov es, ax ; ES = 0 (not strictly needed here but nice to have)

cli ; Disable interrupts while we change SS:SP (safety)
mov ss, ax ; SS = 0 (stack segment starts at physical 0x00000)
mov sp, 0x7C00 ; SP = 0x7C00 -> stack grows DOWN from here
sti ; Re-enable interrupts

mov si, os_boot_msg
call print ; BIOS teletype each byte until we hit 0

hang:
hlt ; Cool the CPU until an interrupt arrives
jmp hang ; Infinite loop ("jmp $" also works)

print:
push si ; Save caller's SI, AX, BX (we modify them)
push ax
push bx
cld ; Ensure LODSB increments SI (DF=0). BIOS usually does, we make it explicit.

.print_loop:
lodsb ; AL = [DS:SI]; SI++ (because DF=0)
test al, al ; Set flags based on AL
jz .done ; If AL == 0, end of string

mov ah, 0x0E ; BIOS teletype function
mov bh, 0x00 ; Page number (always 0 on modern BIOSes)
; mov bl, 0x07 ; (Optional) Text attribute in graphics modes; not needed in text mode
int 0x10 ; BIOS: print character AL, advance cursor
jmp .print_loop

.done:
pop bx
pop ax
pop si
ret

dw 0xAA55 ; Little-endian puts 55 AA at bytes 511..510
