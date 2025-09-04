# Notes

### Following along OpenSecurityTraining2 Dbg1012Debuggers 1012: Introductory GDB


#### To NOT use GEF, and use vanilla GDB, use command 'gdb -nx'
#### (created alias in ~/.bashrc. Use 'gdbv' to run vanilla GDB)

---

### Loading file in gdb

#### fibber:
. gdb --quiet ./fibber_bin

##### OR
. gdb -1
. (gdb) file ./fibber_bin

---

### Useful commands

. info breakpoints ( or 'info break', 'info b', 'i b', ...  ---> Lists created breakpoints
. clear <adress> (use name or '*address')                   ---> Remove the breakpoint
. delete <breakpoint number>  (or 'd' instead of 'delete')  ---> Ditto, using listed number
. disable <breakpoint number>                               ---> We can see them with 'info break'
. enable <breakpoint number>


