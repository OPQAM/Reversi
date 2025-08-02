# Notes

This challenge has a PE fie that much like the ELF files, is requesting a password to be found. Since I didn't want to run a VM on a simple PE exercise, I tried strings and other methods to try and get the info out of the inary. Unfortunately they didn't work, so I had to boot up Ghidra.

See image: 
ghidra_result1.png

In strings I found that there was some 'victory reply' on a successful password entry 'Gratz_man', so I searched for that in Ghidra:
Window -> Defined strings
Show References to -> Address

Since main is checking for the password attempt entry, I need only look at that function.

There were two functions being called. Following them, we finally see that there is another function within with two parameters. One, an int, the other an array of strings. This is basically argc and argv.

So we look at that function. And in that function we finally see, in all it's grace, our password (see image)
