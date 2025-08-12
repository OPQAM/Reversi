# Notes

I've used 

section .note.GNU-stack noalloc noexec nowrite

...at the end of my ASM script in order not to get warnings oncerning security risks. Modern linkers and loaders want us to explicitly declare that our code does not need an executable stack. If we don't declare it, the linker assumes the worst and keeps the stack executable - this behavior is deprecated, though and will be removed in the future.

The stack shouldn't be executable by default. If it's executable, then we get to exploits ahoy land.
