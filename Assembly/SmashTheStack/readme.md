# Compile without securities:
gcc -m32 -fno-stack-protector -z execstack -D_FORTIFY_SOURCE=0 \
    -o example1 example1.c
# Disable ASLR
sudo sysctl -w kernel.randomize_va_space=0

# Re-enable ASLR
sudo sysctl -w kernel.randomize_va_space=2

# Website: adapted version
https://thesquareplanet.com/blog/smashing-the-stack-21st-century/

A buffer overflow, remember, allows us to change the return address of a function. Thus we can change the flow of execution of the program.


