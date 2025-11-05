In the section area we declare a variable by giving a name a type of the data (size) and an initial value

DB = define byte (1 byte)
DW = define word (2 bytes)
DD = define doubleword (4 bytes)
DQ = define quadword (8 bytes)
DT = define ten bytes (10 bytes)

So num DW 2 is a variable called num, with the value 5 and has 4 bytes available

in gdb: step into the system call. And then 
. x/x $ebx
This gives us what is located at the stack at the location of ebx.
