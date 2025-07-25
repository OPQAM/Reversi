# NOTES

Please take into consideration that, for simplicity and briefness sake, we can actually substitute:

CMP eax,4
JE end
JMP loop

with:

CMP eax,4
JL loop

This looks a bit more like a regular loop, in fact. Our 'else' is what comes after our loop, which is the 'end'
