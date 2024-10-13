# Types of moves - examples


### Immediate to memory
`mov [rbx], imm32`
`mov [rbx+rcx*X], imm32`
`mov [rbx+rcx*X+Y], imm32`
### Immediate to register
`mov rbx, imm64`
### Register to register
`mov rbx, rax`
### Register to memory
`mov [rbx], rax`
`mov [rbx+rcx*X], rax`
`mov [rbx+rcx*X+Y], rax`
### Memory to register
`mov rax, [rbx]`
`mov rax, [rbx+rcx*X]`
`mov rax, [rbx+rcx*X+Y]`



