.intel_syntax noprefix
.global _start

# We're using dwords and not qwords. Therefore 32 bits, therefore not rax, but eax
# This is basically an if, if else, and else, but in 32 bits

_start:
        xor eax, eax
        xor ebx, ebx
        xor edx, edx

        mov eax, dword ptr [rdi]
 cmp eax, 0x7f454c46 
        je forty_six             # It's equal to this value, so jump

        cmp eax, 0x00005A4D
        je four_dee              # It's equal to that value, so jump

        # Not equal to any of those values
        mov eax, dword ptr [rdi+4]
        mov ebx, dword ptr [rdi+8]
        imul ebx

        xor edx, edx
        mov ebx, dword ptr [rdi+12]
        imul ebx

        jmp end
forty_six:
        mov eax, dword ptr [rdi+4]
        add eax, dword ptr [rdi+8]
        add eax, dword ptr [rdi+12]

        jmp end

four_dee:
        mov eax, dword ptr [rdi+4]
        sub eax, dword ptr [rdi+8]
        sub eax, dword ptr [rdi+12]

        jmp end

end:
~                     
