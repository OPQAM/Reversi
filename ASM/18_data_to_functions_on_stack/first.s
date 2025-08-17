section .data

section .text
global main

addTwo:
        PUSH ebp          ; Save base pointer of the calling function to preserve the stack frame
        MOV ebp,esp       ; Set up stack frame: base pointer is pointing to current stack pointer
        MOV eax,[ebp+8]   ; Load into eax (1)
        MOV ebx, [ebp+12] ; Load into ebx (4)
        ADD eax,ebx       ; Add arguments and store into eax
        POP ebp           ; Restore the calling function's base pointer and clean up the stack frame
        RET               ; Return from function (eax has resul)

main:
        PUSH 4            ; Push onto stack
        PUSH 1            ; Push onto stack
        CALL addTwo       ; Call the function (go to line 6)
        MOV ebx,eax       ; This is the return location, after we're done with the function
        MOV eax,1
        INT 80h

section .note.GNU-stack noalloc noexec nowrite  
                          ; This is a special section, as noted on entry 17, to explicitly mark whether or not the stack is executable. noexec = not executable, nowrite = non-writable. This will stop GCC's warning.
