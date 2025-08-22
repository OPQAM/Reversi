# A Bootloader

A Bootloader is a small program that runs when we first turn on a computer or devie. It's main job is to initialize the hardware (CPU, memory, storage) and load the OS into memory so that the syste can start running.

### The MyOS folder contains the project we'll be working on (simple bootloader creation)

### Notes:

0x7C00 - the initial loading point.

When BIOS/UEFI loads hte a bot sector from a storage device it leads the first 512 bytes of that disk into memory at this adress.

0xAA55 is the signature at the last 2 bytes of the sector, to mark it as bootable.

#### So, to sum it up, our minimal bootloader must be 512 bytes and end with 0xAA55 to be recognized by BIOS. Its execution starts from 0x7C00

### Sample code from video:

ORG 0x7C00 ; code will be loaded at memory address 0x7C00
BITS 16 ; start at 16 bits (even if you change later)

main:
    HLT ; Halt the CPU until next interrupt (just a tester)

halt:
    JMP halt ; common bootloader trick to prevent CPU
             ; from executing random memory

TIMES 510-($-$$) DB 0 ; fill zeroes up to byte 510
DW 0AA55h    ; as explained: check if sector is bootable


#### $  -> Current address
#### $$ -> Start address of current (ORG) section
#### So, we are using x amount of bytes ($ - $$) and then we're subtracting that from 510. We fill whatever is missing with 0's until 510 bytes and we're making sure the last two bytes are occupied with 0xAA55.

### The Makefile:
  1 ASM=nasm
  2
  3 SRC_DIR=src
  4 BUILD_DIR=build
  5 $(BUILD_DIR)/main.img: $(BUILD_DIR)/main.bin
  6     cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main.img
  7     truncate -s 1440k $(BUILD_DIR)/main.img
  8
  9 $(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
 10     $(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.b    in


#### Notes regarding the Makefile:
- We set up paths easily, to make the makefile readable.
- Line 5 makes sure that we're only rebuilding main.img if main.bin changes.
-Line 6 is copying the binary bootloader into the disk image file.
- Line 7 expands the file to 1440kb, a standard size for floppies.
Remaining bytes are zeroed.
This allows for our main.img to be loaded in emulators like QEMU or VirtualBox.
- etc. We're assembling the binary and we have an output file in main.bin

#### We can now write 'make' in the terminal and have the compilation done.

### Using a virtual machine to load the bootloader:
qemu-system-i386 -fda build/main.img

